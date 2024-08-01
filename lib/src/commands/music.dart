// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:math' as math;

import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:radio_horizon/src/checks.dart';

final _enMusicCommand = AppLocale.en.translations.commands.music;
final _enPlayCommand = _enMusicCommand.children.play;

final _logger = Logger('command/music');
final _getIt = GetIt.instance;

ChatGroup music = ChatGroup(
  _enMusicCommand.command,
  _enMusicCommand.description,
  checks: [
    GuildCheck.all(),
    userConnectedToVoiceChannelCheck,
    sameVoiceChannelOrDisconnectedCheck,
  ],
  children: [
    ChatCommand(
      _enPlayCommand.command,
      _enPlayCommand.description,
      id('music-play', (
        IChatContext context,
        @Description('The name/url of the song/playlist to play')
        @Autocomplete(autocompleteMusicQuery)
        String query,
      ) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).music.children.play;

        _logger.info(
          '''
ChatCommand:music-play: {
  'query': $query,
  'guild': ${context.guild?.id.toString() ?? 'null'},
  'guild_name': ${context.guild?.name ?? 'null'},
  'guild_preferred_locale': ${context.guild?.preferredLocale ?? 'null'},
  'channel': ${context.channel.id},
  'user': ${context.member?.id.toString() ?? 'null'},
}''',
        );

        final node = _getIt
            .get<MusicService>()
            .cluster
            .getOrCreatePlayerNode(context.guild!.id);
        await connectIfNeeded(context);
        final result = await node.autoSearch(query);

        if (result.tracks.isEmpty) {
          await context.respond(
            MessageBuilder.content(
              commandTranslations.noResults(query: query),
            ),
          );
          return;
        }

        if (result.playlistInfo.name != null) {
          for (final track in result.tracks) {
            node
                .play(
                  context.guild!.id,
                  track,
                  requester: context.member!.id,
                  channelId: context.channel.id,
                )
                .queue();
          }

          await context.respond(
            MessageBuilder.content(
              commandTranslations.playlistEnqueued(
                name: result.playlistInfo.name ?? '(Unknown)',
                query: query,
              ),
            ),
          );
        } else {
          node
              .play(
                context.guild!.id,
                result.tracks[0],
                requester: context.member!.id,
                channelId: context.channel.id,
              )
              .queue();
          await context.respond(
            MessageBuilder.content(
              commandTranslations.songEnqueued(
                title: result.tracks[0].info?.title ?? '(Unknown)',
                query: query,
              ),
            ),
          );
        }

        await _getIt
            .get<DatabaseService>()
            .deleteRadioFromList(context.guild!.id);
      }),
      localizedDescriptions: localizedValues(
        (translations) => translations.commands.music.children.play.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.music.children.play.command,
      ),
    ),
  ],
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.music.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.music.command,
  ),
);

FutureOr<Iterable<ArgChoiceBuilder>?> autocompleteMusicQuery(
  AutocompleteContext context,
) async {
  final query = context.currentValue;

  _logger.info(
    '''
ChatCommand:music-play: autocompletion: {
  'query': $query,
  'guild': ${context.guild?.id.toString() ?? 'null'},
  'guild_name': ${context.guild?.name ?? 'null'},
  'guild_preferred_locale': ${context.guild?.preferredLocale ?? 'null'},
  'channel': ${context.channel.id},
  'user': ${context.member?.id.toString() ?? 'null'},
}''',
  );

  final node = _getIt
      .get<MusicService>()
      .cluster
      .getOrCreatePlayerNode(context.guild!.id);
  final response =
      await node.autoSearch(query).timeout(const Duration(milliseconds: 2500));

  return response.tracks.map(
    (e) => ArgChoiceBuilder(
      e.info!.title.substring(0, math.min(e.info!.title.length, 100)),
      e.info!.uri.substring(0, math.min(e.info!.uri.length, 100)),
    ),
  );
}
