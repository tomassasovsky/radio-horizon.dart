// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:nyxx_pagination/nyxx_pagination.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:radio_horizon/src/checks.dart';
import 'package:radio_horizon/src/models/song_recognition/current_station_info.dart';
import 'package:retry/retry.dart';

final _enRadioCommand = AppLocale.en.translations.commands.radio;
final _enPlayCommand = _enRadioCommand.children.play;
final _enRecognizeCommand = _enRadioCommand.children.recognize;

final uuidRegExp = RegExp(
  '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}',
);

const _radioBrowserClient =
    RadioBrowserApi.fromHost('de1.api.radio-browser.info');

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

        await usage?.sendEvent(
          'ChatCommand:radio-play',
          'call',
          parameters: {
            'query': query,
            'guild': context.guild?.id.toString() ?? 'null',
            'guild_name': context.guild?.name ?? 'null',
            'guild_preferred_locale': context.guild?.preferredLocale ?? 'null',
            'channel': context.channel.id.toString(),
            'user': context.member?.id.toString() ?? 'null',
          },
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

        SongRecognitionService.instance
            .setCurrentRadio(context.guild!.id, bestMatch);

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
        MusicLinksResponse? linksResponse;

        try {
          final recognitionService = SongRecognitionService.instance;
          final guildId = context.guild!.id;

          final stopwatch = Stopwatch()..start();
          var recognitionSampleDuration = 10;

          final guildRadio = recognitionService.currentRadio(guildId);

          try {
            final info =
                await recognitionService.getCurrentStationInfo(guildRadio);
            if (!info.hasTitle) {
              throw Exception('No title');
            }
            final node = MusicService.instance.cluster
                .getOrCreatePlayerNode(context.guild!.id);
            final tracks = await node.autoSearch(info.title!);
            stationInfo = info.copyWith(
              image:
                  'https://img.youtube.com/vi/${tracks.tracks.first.info?.identifier}/hqdefault.jpg',
            );
          } catch (e) {
            ShazamResult? result;
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
          }

          try {
            linksResponse = await SongRecognitionService.instance
                .getMusicLinks(stationInfo.title!);
          } catch (e) {
            await usage?.sendEvent('ChatCommand:radio-recognize', 'links');
          }

          final color = getRandomColor();
          stopwatch.stop();

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
            ..thumbnailUrl = stationInfo.image;

          final genre = stationInfo.genre;
          if (genre != null) {
            embed.addField(
              name: commandTranslations.genreField,
              content: genre,
            );
          }

          embed.addField(
            name: commandTranslations.computationalTimeField,
            content: '${stopwatch.elapsedMilliseconds}ms',
          );

          final lyricsPages = stationInfo.lyricsPages(color: color);
          if (lyricsPages == null || lyricsPages.isEmpty) {
            final builder = ComponentMessageBuilder()..embeds = [embed];
            linksResponse?.componentRows.forEach(builder.addComponentRow);
            return await context.respond(builder);
          }

          final paginator = EmbedComponentPagination(
            context.commands.interactions!,
            [embed, ...lyricsPages],
            user: context.user,
          );

          final messageBuilder = paginator.initMessageBuilder();
          linksResponse?.componentRows.forEach(messageBuilder.addComponentRow);

          await context.respond(messageBuilder);
        } catch (e, stacktrace) {
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
    (e) => ArgChoiceBuilder(
      e.name,
      '${e.name} (${e.stationUUID})',
    ),
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
