// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:injector/injector.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_extensions/nyxx_extensions.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:radio_horizon/src/checks.dart';
import 'package:radio_horizon/src/helpers/random_string.dart';
import 'package:radio_horizon/src/models/song_recognition/current_station_info.dart';
import 'package:retry/retry.dart';
import 'package:shazam_client/shazam_client.dart';

final _enRadioCommand = AppLocale.en.translations.commands.radio;
final _enPlayCommand = _enRadioCommand.children.play;
final _enPlayRandomCommand = _enRadioCommand.children.playRandom;
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
      id('radioplay', (
        ChatContext context,
        @Description('The name of the Radio Station to play')
        @Autocomplete(autocompleteRadioQuery)
        String query,
      ) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).radio.children.play;

        await context.respond(
          MessageBuilder(
            content: commandTranslations.searching(query: query),
          ),
        );

        final player = await connectLavalink(context);

        late final RadioBrowserListResponse<Station> stations;

        if (uuidRegExp.hasMatch(query)) {
          final match = uuidRegExp.stringMatch(query)!;
          stations =
              await _radioBrowserClient.getStationsByUUID(uuids: [match]);
        } else {
          stations = await _radioBrowserClient.getStationsByName(name: query);
        }

        if (stations.items.isEmpty) {
          return context.respond(
            MessageBuilder(
              content: commandTranslations.noResults(query: query),
            ),
          );
        }

        final bestMatch = stations.items.first;
        await _radioBrowserClient.clickStation(
          uuid: bestMatch.stationUUID,
        );

        final lavalinkClient = Injector.appInstance.get<LavalinkClient>();

        final result = await lavalinkClient
            .loadTrack(bestMatch.urlResolved ?? bestMatch.url);
        if (result is! TrackLoadResult) {
          return context.respond(
            MessageBuilder(
              content: commandTranslations.noResults(query: query),
            ),
          );
        }

        await context.respond(
          MessageBuilder(
            content: commandTranslations.stationEnqueued(
              name: result.data.info.title,
              query: query,
            ),
          ),
        );

        final track = result.data;
        await player?.play(track);

        final databaseService = Injector.appInstance.get<DatabaseService>();
        await databaseService.setCurrentRadio(
          context.guild!.id,
          context.guild!.voiceStates[context.member!.id]!.channelId!,
          context.channel.id,
          bestMatch,
        );

        final embed = EmbedBuilder()
          ..color = getRandomColor()
          ..title = commandTranslations.startedPlaying
          ..description = commandTranslations.startedPlayingDescription(
            radio: bestMatch.name,
            mention: context.member?.user?.mention ?? '(Unknown)',
          );

        await context.respond(MessageBuilder(embeds: [embed]));
      }),
      localizedDescriptions: localizedValues(
        (translations) => translations.commands.radio.children.play.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.radio.children.play.command,
      ),
    ),
    ChatCommand(
      _enPlayRandomCommand.command,
      _enPlayRandomCommand.description,
      id('radio-play-random', (
        ChatContext context,
      ) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).radio.children.playRandom;

        await context.respond(
          MessageBuilder(
            content: commandTranslations.searching,
          ),
        );

        final radios = await _radioBrowserClient.getStationsByName(
          name: getRandomString(1),
          parameters: const InputParameters(limit: 10),
        );

        final randomIndex = math.Random().nextInt(radios.items.length);
        final radio = radios.items[randomIndex];

        final lavalinkClient = Injector.appInstance.get<LavalinkClient>();
        final player = await connectLavalink(context);
        await _radioBrowserClient.clickStation(uuid: radio.stationUUID);

        final result =
            await lavalinkClient.loadTrack(radio.urlResolved ?? radio.url);
        if (result is! TrackLoadResult) {
          return context.respond(
            MessageBuilder(content: commandTranslations.errors.noResults),
          );
        }

        final track = result.data;
        await player?.play(track);

        final databaseService = Injector.appInstance.get<DatabaseService>();
        await databaseService.setCurrentRadio(
          context.guild!.id,
          context.guild!.voiceStates[context.member!.id]!.channelId!,
          context.channel.id,
          radio,
        );

        final embed = EmbedBuilder()
          ..color = getRandomColor()
          ..title = commandTranslations.startedPlaying
          ..description = commandTranslations.startedPlayingDescription(
            radio: radio.name,
            mention: context.member?.user?.mention ?? '(Unknown)',
          );

        await context.respond(MessageBuilder(embeds: [embed]));
      }),
      localizedDescriptions: localizedValues(
        (translations) =>
            translations.commands.radio.children.playRandom.description,
      ),
      localizedNames: localizedValues(
        (translations) =>
            translations.commands.radio.children.playRandom.command,
      ),
    ),
    ChatCommand(
      _enRecognizeCommand.command,
      _enRecognizeCommand.description,
      id('radio-recognize', (
        ChatContext context,
      ) async {
        context as InteractionChatContext;
        final translations = getCommandTranslations(context);
        final commandTranslations = translations.radio.children.recognize;
        CurrentStationInfo? stationInfo;

        try {
          final databaseService = Injector.appInstance.get<DatabaseService>();
          final recognitionService =
              Injector.appInstance.get<SongRecognitionService>();

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
                MessageBuilder(
                  embeds: [
                    EmbedBuilder(
                      color: const DiscordColor.fromRgb(255, 0, 0),
                      title: commandTranslations.errors.noResults,
                    ),
                  ],
                ),
              );
              return null;
            }

            stationInfo =
                CurrentStationInfo.fromShazamResult(result!, guildRadio);
          } catch (e) {
            await context.respond(
              MessageBuilder(
                embeds: [
                  EmbedBuilder(
                    color: const DiscordColor.fromRgb(255, 0, 0),
                    title: commandTranslations.errors.noResults,
                  ),
                ],
              ),
            );
            return null;
          }

          final color = getRandomColor();
          final genre = stationInfo.genre;

          final embed = EmbedBuilder(
            color: color,
            title: stationInfo.title,
            description: commandTranslations.requestedBy(
              mention: context.member?.user?.mention ?? '(Unknown)',
            ),
            thumbnail: stationInfo.image != null
                ? EmbedThumbnailBuilder(url: Uri.parse(stationInfo.image!))
                : null,
            url: stationInfo.url != null ? Uri.parse(stationInfo.url!) : null,
            fields: [
              if (stationInfo.name != null)
                EmbedFieldBuilder(
                  name: commandTranslations.radioStationField,
                  value: stationInfo.name!,
                  isInline: true,
                ),
              if (stationInfo.image != null && stationInfo.url != null)
                EmbedFieldBuilder(
                  name: stationInfo.image!,
                  value: stationInfo.url!,
                  isInline: true,
                ),
              if (genre != null)
                EmbedFieldBuilder(
                  name: commandTranslations.genreField,
                  value: genre,
                  isInline: true,
                ),
            ],
          );

          await context.respond(MessageBuilder(embeds: [embed]));
        } catch (e, stacktrace) {
          _logger.severe(
            'Failed to recognize radio',
            e,
            stacktrace,
          );

          await context.respond(
            MessageBuilder(
              embeds: [
                EmbedBuilder(
                  color: const DiscordColor.fromRgb(255, 0, 0),
                  title: commandTranslations.errors.title,
                  description:
                      handleRecognitionExceptions(e, stacktrace, translations),
                ),
              ],
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
        ChatContext context,
      ) async {
        context as InteractionChatContext;
        final translations = getCommandTranslations(context);
        final commandTranslations = translations.radio.children.upvote;

        late GuildRadio? guildRadio;
        try {
          guildRadio = await Injector.appInstance
              .get<DatabaseService>()
              .currentRadio(context.guild!.id);
        } on RadioNotPlayingException {
          await context.respond(
            MessageBuilder(
              embeds: [
                EmbedBuilder(
                  color: const DiscordColor.fromRgb(255, 0, 0),
                  title: commandTranslations.errors.noRadioPlaying,
                ),
              ],
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

        await context.respond(MessageBuilder(embeds: [embed]));
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

FutureOr<Iterable<CommandOptionChoiceBuilder<dynamic>>?> autocompleteRadioQuery(
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

      return CommandOptionChoiceBuilder(
        name: e.name.substring(0, math.min(e.name.length, 100)),
        // limit the name's length to 59 characters, because Discord has a limit
        // of 100 characters for the choice's and value.
        // 59 is due to the fact that the station's UUID is also added to the
        // value, and it's 39 characters long (32 digits + hyphens + parenthesis
        // around the UUID + pre-text space).
        //
        // The value is used to identify the station when the user selects it.
        value: '${e.name.length >= 58 ? '$croppedName...' : croppedName} '
            '(${e.stationUUID})',
      );
    },
  );
}

String handleRecognitionExceptions(
  Object e,
  StackTrace stackTrace,
  TranslationsCommandsEn commandTranslations,
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
