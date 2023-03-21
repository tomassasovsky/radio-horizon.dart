// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:radio_horizon/src/checks.dart';

final _enMusicCommand = AppLocale.en.translations.commands.music;
final _enPlayCommand = _enMusicCommand.children.play;
final _enSkipCommand = _enMusicCommand.children.skip;
final _enStopCommand = _enMusicCommand.children.stop;
final _enJoinCommand = _enMusicCommand.children.join;
final _enLeaveCommand = _enMusicCommand.children.leave;
final _enPauseCommand = _enMusicCommand.children.pause;
final _enResumeCommand = _enMusicCommand.children.resume;
final _enVolumeCommand = _enMusicCommand.children.volume;

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

        await usage?.sendEvent(
          'ChatCommand:music-play',
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

        final node = MusicService.instance.cluster
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

        SongRecognitionService.instance.deleteRadioFromList(context.guild!.id);
      }),
      localizedDescriptions: localizedValues(
        (translations) => translations.commands.music.children.play.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.music.children.play.command,
      ),
    ),
    ChatCommand(
      _enSkipCommand.command,
      _enSkipCommand.description,
      checks: [connectedToAVoiceChannelCheck],
      id('music-skip', (IChatContext context) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).music.children.skip;

        await usage?.sendEvent(
          'ChatCommand:music-skip',
          'call',
          parameters: {
            'guild': context.guild?.id.toString() ?? 'null',
            'guild_name': context.guild?.name ?? 'null',
            'guild_preferred_locale': context.guild?.preferredLocale ?? 'null',
            'channel': context.channel.id.toString(),
            'user': context.member?.id.toString() ?? 'null',
          },
        );

        final node = MusicService.instance.cluster
            .getOrCreatePlayerNode(context.guild!.id);
        final player = node.players[context.guild!.id]!;

        if (player.queue.isEmpty) {
          await context.respond(
            MessageBuilder.content(commandTranslations.nothingPlaying),
          );
          return;
        }

        node.skip(context.guild!.id);
        await context.respond(
          MessageBuilder.content(commandTranslations.skipped),
        );
      }),
      localizedDescriptions: localizedValues(
        (translations) => translations.commands.music.children.skip.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.music.children.skip.command,
      ),
    ),
    ChatCommand(
      _enStopCommand.command,
      _enStopCommand.description,
      checks: [connectedToAVoiceChannelCheck],
      id('music-stop', (IChatContext context) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).music.children.stop;

        await usage?.sendEvent(
          'ChatCommand:music-stop',
          'call',
          parameters: {
            'guild': context.guild?.id.toString() ?? 'null',
            'guild_name': context.guild?.name ?? 'null',
            'guild_preferred_locale': context.guild?.preferredLocale ?? 'null',
            'channel': context.channel.id.toString(),
            'user': context.member?.id.toString() ?? 'null',
          },
        );

        MusicService.instance.cluster
            .getOrCreatePlayerNode(context.guild!.id)
            .stop(context.guild!.id);
        await context
            .respond(MessageBuilder.content(commandTranslations.stopped));
      }),
      localizedDescriptions: localizedValues(
        (translations) => translations.commands.music.children.stop.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.music.children.stop.command,
      ),
    ),
    ChatCommand(
      _enLeaveCommand.command,
      _enLeaveCommand.description,
      checks: [connectedToAVoiceChannelCheck],
      id('music-leave', (IChatContext context) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).music.children.leave;

        await usage?.sendEvent(
          'ChatCommand:music-leave',
          'call',
          parameters: {
            'guild': context.guild?.id.toString() ?? 'null',
            'guild_name': context.guild?.name ?? 'null',
            'guild_preferred_locale': context.guild?.preferredLocale ?? 'null',
            'channel': context.channel.id.toString(),
            'user': context.member?.id.toString() ?? 'null',
          },
        );

        MusicService.instance.cluster
            .getOrCreatePlayerNode(context.guild!.id)
            .destroy(context.guild!.id);
        context.guild!.shard.changeVoiceState(context.guild!.id, null);
        await context.respond(MessageBuilder.content(commandTranslations.left));
      }),
      localizedDescriptions: localizedValues(
        (translations) =>
            translations.commands.music.children.leave.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.music.children.leave.command,
      ),
    ),
    ChatCommand(
      _enJoinCommand.command,
      _enJoinCommand.description,
      checks: [notConnectedToAVoiceChannelCheck],
      id('music-join', (IChatContext context) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).music.children.join;

        await usage?.sendEvent(
          'ChatCommand:music-join',
          'call',
          parameters: {
            'guild': context.guild?.id.toString() ?? 'null',
            'guild_name': context.guild?.name ?? 'null',
            'guild_preferred_locale': context.guild?.preferredLocale ?? 'null',
            'channel': context.channel.id.toString(),
            'user': context.member?.id.toString() ?? 'null',
          },
        );

        MusicService.instance.cluster.getOrCreatePlayerNode(context.guild!.id);
        await connectIfNeeded(context);
        await context
            .respond(MessageBuilder.content(commandTranslations.joined));
      }),
      localizedDescriptions: localizedValues(
        (translations) => translations.commands.music.children.join.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.music.children.join.command,
      ),
    ),
    ChatCommand(
      _enVolumeCommand.command,
      _enVolumeCommand.description,
      checks: [connectedToAVoiceChannelCheck],
      id('music-volume', (
        IChatContext context,
        @Description(
          'The new volume, this value must be contained between 0 and 1000',
        )
        @UseConverter(IntConverter(min: 0, max: 1000))
            int volume,
      ) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).music.children.volume;

        await usage?.sendEvent(
          'ChatCommand:music-volume',
          'call',
          parameters: {
            'volume': '$volume',
            'guild': context.guild?.id.toString() ?? 'null',
            'guild_name': context.guild?.name ?? 'null',
            'guild_preferred_locale': context.guild?.preferredLocale ?? 'null',
            'channel': context.channel.id.toString(),
            'user': context.member?.id.toString() ?? 'null',
          },
        );

        MusicService.instance.cluster
            .getOrCreatePlayerNode(context.guild!.id)
            .volume(
              context.guild!.id,
              volume,
            );

        await context.respond(
          MessageBuilder.content(
            commandTranslations.volumeSet(volume: volume),
          ),
        );
      }),
      localizedDescriptions: localizedValues(
        (translations) =>
            translations.commands.music.children.volume.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.music.children.volume.command,
      ),
    ),
    ChatCommand(
      _enPauseCommand.command,
      _enPauseCommand.description,
      id('music-pause', (IChatContext context) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).music.children.pause;

        await usage?.sendEvent(
          'ChatCommand:music-pause',
          'call',
          parameters: {
            'guild': context.guild?.id.toString() ?? 'null',
            'guild_name': context.guild?.name ?? 'null',
            'guild_preferred_locale': context.guild?.preferredLocale ?? 'null',
            'channel': context.channel.id.toString(),
            'user': context.member?.id.toString() ?? 'null',
          },
        );

        MusicService.instance.cluster
            .getOrCreatePlayerNode(context.guild!.id)
            .pause(context.guild!.id);
        await context
            .respond(MessageBuilder.content(commandTranslations.paused));
      }),
      localizedDescriptions: localizedValues(
        (translations) =>
            translations.commands.music.children.pause.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.music.children.pause.command,
      ),
    ),
    ChatCommand(
      _enResumeCommand.command,
      _enResumeCommand.description,
      id('music-resume', (IChatContext context) async {
        context as InteractionChatContext;
        final commandTranslations =
            getCommandTranslations(context).music.children.resume;

        await usage?.sendEvent(
          'ChatCommand:music-resume',
          'call',
          parameters: {
            'guild': context.guild?.id.toString() ?? 'null',
            'guild_name': context.guild?.name ?? 'null',
            'guild_preferred_locale': context.guild?.preferredLocale ?? 'null',
            'channel': context.channel.id.toString(),
            'user': context.member?.id.toString() ?? 'null',
          },
        );

        MusicService.instance.cluster
            .getOrCreatePlayerNode(context.guild!.id)
            .resume(context.guild!.id);
        await context
            .respond(MessageBuilder.content(commandTranslations.resumed));
      }),
      localizedDescriptions: localizedValues(
        (translations) =>
            translations.commands.music.children.resume.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.music.children.resume.command,
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

  await usage?.sendEvent(
    'ChatCommand:music-play',
    'autocompletion',
    parameters: {
      'query': query,
      'guild': context.guild?.id.toString() ?? 'null',
      'guild_name': context.guild?.name ?? 'null',
      'guild_preferred_locale': context.guild?.preferredLocale ?? 'null',
      'channel': context.channel.id.toString(),
      'user': context.member?.id.toString() ?? 'null',
    },
  );

  final node =
      MusicService.instance.cluster.getOrCreatePlayerNode(context.guild!.id);
  final response =
      await node.autoSearch(query).timeout(const Duration(milliseconds: 2500));

  return response.tracks.map(
    (e) => ArgChoiceBuilder(
      e.info!.title,
      e.info!.uri,
    ),
  );
}
