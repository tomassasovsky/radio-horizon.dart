// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:nyxx_pagination/nyxx_pagination.dart';
import 'package:radio_garden/radio_garden.dart';
import 'package:radio_garden/src/checks.dart';
import 'package:retry/retry.dart';

final _enRadioCommand = AppLocale.en.translations.commands.radio;
final _enPlayCommand = _enRadioCommand.children.play;
final _enRecognizeCommand = _enRadioCommand.children.recognize;

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
        @Autocomplete(_autocompleteCallback)
            String query,
      ) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).radio.children.play;

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

        final radio = await radioByName(query);
        if (radio == null || (radio.hits?.hits?.isEmpty ?? true)) {
          await context.respond(
            MessageBuilder.content(
              commandTranslations.noResults(query: query),
            ),
          );
          return;
        }

        final result = await node.searchTracks(radio.uri!);
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
            .setCurrentRadio(context.guild!.id.toString(), radio);

        final embed = EmbedBuilder()
          ..color = getRandomColor()
          ..title = commandTranslations.startedPlaying
          ..description = commandTranslations.startedPlayingDescription(
            radio: radio.title.toString(),
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

        try {
          final recognitionService = SongRecognitionService.instance;
          final guildId = context.guild!.id.toString();

          final stopwatch = Stopwatch()..start();

          late ShazamResult result;
          var recognitionSampleDuration = 10;

          final guildRadio = recognitionService.currentRadio(guildId);
          await retry(
            () async {
              result = await recognitionService.identify(
                guildRadio.radio.radioId,
                recognitionSampleDuration,
              );
            },
            maxDelay: const Duration(minutes: 2),
            retryIf: (e) => true,
            onRetry: (e) {
              recognitionSampleDuration +=
                  (recognitionSampleDuration * 0.25).toInt();
            },
          ).timeout(const Duration(minutes: 2));

          final links = await SongRecognitionService.instance
              .getMusicLinks('${result.title} ${result.subtitle}')
              .onError((error, stackTrace) => MusicLinksResponse.empty());

          final color = getRandomColor();
          stopwatch.stop();

          final embed = EmbedBuilder()
            ..color = color
            ..title = result.title
            ..description = commandTranslations.requestedBy(
              mention: context.member?.mention ?? '(Unknown)',
            )
            ..addField(
              name: commandTranslations.artistField,
              content: result.subtitle,
            )
            ..imageUrl = result.share?.image;

          final genre = result.genres?.primary;
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

          final lyricsPages = result.lyricsPages(color: color);
          if (lyricsPages == null || lyricsPages.isEmpty) {
            final builder = ComponentMessageBuilder()..embeds = [embed];
            links.componentRows.forEach(builder.addComponentRow);
            return await context.respond(builder);
          }

          final paginator = EmbedComponentPagination(
            context.commands.interactions,
            [embed, ...lyricsPages],
            user: context.user,
          );

          final messageBuilder = paginator.initMessageBuilder();
          links.componentRows.forEach(messageBuilder.addComponentRow);

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

FutureOr<Iterable<ArgChoiceBuilder>?> _autocompleteCallback(
  AutocompleteContext context,
) async {
  final query = context.currentValue;
  final response = await radioByName(query)
      .timeout(const Duration(milliseconds: 2500), onTimeout: () => null);

  final hits = response?.hits?.hits;

  if (hits == null || hits.isEmpty) {
    return null;
  }

  return hits.map(
    (e) => ArgChoiceBuilder(
      e.source?.title ?? 'NO TITLE',
      '${e.source?.title} (${e.source?.url.split('/').last})',
    ),
  );
}

Future<RadioGardenSearchResponse?> radioByName(String name) async {
  const searchUrl = 'http://radio.garden/api/search?q=';

  Logger('Radio#radioByName').info('Searching for radio station $name');
  final response = await http.get(
    Uri.parse('$searchUrl$name'),
  );

  final searchResponse = radioGardenSearchResponseFromJson(response.body);

  Logger('Radio#radioByName').info(
    'Found ${searchResponse.hits?.hits?.length ?? 0} radio stations for $name',
  );
  return searchResponse;
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
