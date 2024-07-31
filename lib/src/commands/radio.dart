// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:radio_horizon/src/checks.dart';
import 'package:radio_horizon/src/models/song_recognition/current_station_info.dart';
import 'package:retry/retry.dart';
import 'package:shazam_client/shazam_client.dart';

final _enRadioCommand = AppLocale.en.translations.commands.radio;
final _enPlayCommand = _enRadioCommand.children.play;
final _enRecognizeCommand = _enRadioCommand.children.recognize;
final _enUpvoteCommand = _enRadioCommand.children.upvote;

final uuidRegExp = RegExp(
  '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}',
);

const _radioBrowserClient =
    RadioBrowserApi.fromHost('de1.api.radio-browser.info');

final _logger = Logger('command/radio');

ChatGroup radio = ChatGroup(
  _enRadioCommand.command,
  _enRadioCommand.description,
  checks: [
    GuildCheck.all(),
    userConnectedToVoiceChannelCheck,
    sameVoiceChannelOrDisconnectedCheck,
  ],
  children: [
    ChatCommand(
      _enPlayCommand.command,
      _enPlayCommand.description,
      id('radio-play', (
        IChatContext context,
        @Description('The name of the Radio Station to play')
        @Autocomplete(autocompleteRadioQuery)
        String query,
      ) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).radio.children.play;

        await context.respond(
          MessageBuilder.content(
            commandTranslations.searching(query: query),
          ),
        );

        _logger.info(
          '''
ChatCommand:radio-play: {
  'query': $query,
  'guild': ${context.guild?.id.toString() ?? 'null'},
  'guild_name': ${context.guild?.name ?? 'null'},
  'guild_preferred_locale': ${context.guild?.preferredLocale ?? 'null'},
  'channel': ${context.channel.id},
  'user': ${context.member?.id.toString() ?? 'null'},
}''',
        );

        await connectIfNeeded(context, replace: true);

        final node = MusicService.instance.cluster
            .getOrCreatePlayerNode(context.guild!.id);

        late final RadioBrowserListResponse<Station> stations;

        if (uuidRegExp.hasMatch(query)) {
          final match = uuidRegExp.stringMatch(query)!;
          stations =
              await _radioBrowserClient.getStationsByUUID(uuids: [match]);
        } else {
          stations = await _radioBrowserClient.getStationsByName(name: query);
        }

        if (stations.items.isEmpty) {
          await context.respond(
            MessageBuilder.content(
              commandTranslations.noResults(query: query),
            ),
          );
          return;
        }

        final bestMatch = stations.items.first;
        await _radioBrowserClient.clickStation(
          uuid: bestMatch.stationUUID,
        );

        final result =
            await node.searchTracks(bestMatch.urlResolved ?? bestMatch.url);
        if (result.tracks.isEmpty) {
          await context.respond(
            MessageBuilder.content(
              commandTranslations.noResults(query: query),
            ),
          );
          return;
        }

        final track = result.tracks.first;
        node
          ..players[context.guild!.id]!.queue.clear()
          ..play(
            context.guild!.id,
            track,
            replace: true,
            requester: context.member!.id,
            channelId: context.channel.id,
          ).startPlaying();

        final databaseService = DatabaseService.instance;
        await databaseService.setCurrentRadio(
          context.guild!.id,
          context.member!.voiceState!.channel!.id,
          context.channel.id,
          bestMatch,
        );

        final embed = EmbedBuilder()
          ..color = getRandomColor()
          ..title = commandTranslations.startedPlaying
          ..description = commandTranslations.startedPlayingDescription(
            radio: bestMatch.name,
            mention: context.member?.mention ?? '(Unknown)',
          );

        await context.respond(MessageBuilder.embed(embed));
      }),
      localizedDescriptions: localizedValues(
        (translations) => translations.commands.radio.children.play.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.radio.children.play.command,
      ),
    ),
    ChatCommand(
      _enRecognizeCommand.command,
      _enRecognizeCommand.description,
      id('radio-recognize', (
        IChatContext context,
      ) async {
        context as InteractionChatContext;
        final translations = getCommandTranslations(context);
        final commandTranslations = translations.radio.children.recognize;
        CurrentStationInfo? stationInfo;

        try {
          final recognitionService = SongRecognitionService.instance;
          final databaseService = DatabaseService.instance;
          final guildId = context.guild!.id;

          var recognitionSampleDuration = 10;

          final guildRadio = await databaseService.currentRadio(guildId);

          try {
            SongModel? result;
            await retry(
              () async {
                result = await recognitionService.identify(
                  guildRadio.station.urlResolved ?? guildRadio.station.url,
                  recognitionSampleDuration,
                );
              },
              maxDelay: const Duration(minutes: 2),
              retryIf: (e) => true,
              onRetry: (e) {
                recognitionSampleDuration +=
                    (recognitionSampleDuration * 0.25).toInt();
              },
            ).timeout(const Duration(minutes: 1));

            if (result == null) {
              await context.respond(
                MessageBuilder.embed(
                  EmbedBuilder()
                    ..color = DiscordColor.red
                    ..title = commandTranslations.errors.noResults,
                ),
              );
              return null;
            }

            stationInfo =
                CurrentStationInfo.fromShazamResult(result!, guildRadio);
          } catch (e) {
            await context.respond(
              MessageBuilder.embed(
                EmbedBuilder()
                  ..color = DiscordColor.red
                  ..title = commandTranslations.errors.noResults,
              ),
            );
            return null;
          }

          final color = getRandomColor();

          final embed = EmbedBuilder()
            ..color = color
            ..title = stationInfo.title
            ..description = commandTranslations.requestedBy(
              mention: context.member?.mention ?? '(Unknown)',
            )
            ..addField(
              name: commandTranslations.radioStationField,
              content: stationInfo.name,
            )
            ..thumbnailUrl = stationInfo.image
            ..url = stationInfo.url;

          final genre = stationInfo.genre;
          if (genre != null) {
            embed.addField(
              name: commandTranslations.genreField,
              content: genre,
            );
          }

          await context.respond(MessageBuilder.embed(embed));
        } catch (e, stacktrace) {
          _logger.severe(
            'Failed to recognize radio',
            e,
            stacktrace,
          );

          await context.respond(
            MessageBuilder.embed(
              EmbedBuilder()
                ..color = DiscordColor.red
                ..title = commandTranslations.errors.title
                ..description =
                    handleRecognitionExceptions(e, stacktrace, translations),
            ),
          );
        }
      }),
      localizedDescriptions: localizedValues(
        (translations) =>
            translations.commands.radio.children.recognize.description,
      ),
      localizedNames: localizedValues(
        (translations) =>
            translations.commands.radio.children.recognize.command,
      ),
    ),
    ChatCommand(
      _enUpvoteCommand.command,
      _enUpvoteCommand.description,
      id('radio-upvote', (
        IChatContext context,
      ) async {
        context as InteractionChatContext;
        final translations = getCommandTranslations(context);
        final commandTranslations = translations.radio.children.upvote;

        late GuildRadio? guildRadio;
        try {
          guildRadio =
              await DatabaseService.instance.currentRadio(context.guild!.id);
        } on RadioNotPlayingException {
          await context.respond(
            MessageBuilder.embed(
              EmbedBuilder()
                ..color = DiscordColor.red
                ..title = commandTranslations.errors.noRadioPlaying,
            ),
          );
          return;
        }

        await _radioBrowserClient.voteForStation(
          stationUUID: guildRadio.station.stationUUID,
        );

        final embed = EmbedBuilder()
          ..color = getRandomColor()
          ..title = commandTranslations.success
          ..description = commandTranslations.successDescription(
            radio: guildRadio.station.name,
          );

        await context.respond(MessageBuilder.embed(embed));
      }),
    ),
  ],
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.radio.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.radio.command,
  ),
);

FutureOr<Iterable<ArgChoiceBuilder>?> autocompleteRadioQuery(
  AutocompleteContext context,
) async {
  final query = context.currentValue;
  late final RadioBrowserListResponse<Station> response;
  if (query.isEmpty) {
    response = await _radioBrowserClient.getAllStations(
      parameters: const InputParameters(limit: 10),
    );
  } else {
    response = await _radioBrowserClient.getStationsByName(
      name: query,
      parameters: const InputParameters(limit: 10),
    );
  }

  final hits = response.items;

  if (hits.isEmpty) {
    return null;
  }

  return hits.map(
    (e) {
      final croppedName =
          e.name.substring(0, math.min(e.name.length, 58)).trim();

      return ArgChoiceBuilder(
        e.name.substring(0, math.min(e.name.length, 100)),
        // limit the name's length to 59 characters, because Discord has a limit
        // of 100 characters for the choice's and value.
        // 59 is due to the fact that the station's UUID is also added to the
        // value, and it's 39 characters long (32 digits + hyphens + parenthesis
        // around the UUID + pre-text space).
        //
        // The value is used to identify the station when the user selects it.
        '${e.name.length >= 58 ? '$croppedName...' : croppedName} '
        '(${e.stationUUID})',
      );
    },
  );
}

String handleRecognitionExceptions(
  Object e,
  StackTrace stackTrace,
  StringsCommandsEn commandTranslations,
) {
  log('Exception: ', error: e, stackTrace: stackTrace);
  final errors = commandTranslations.radio.children.recognize.errors;

  switch (e.runtimeType) {
    case RadioNotPlayingException:
      return errors.noRadioPlaying;
    case RadioCantCommunicateWithServer:
      return errors.radioCantCommunicate;
    case RadioCantIdentifySongException:
    default:
      return errors.noResults;
  }
}
