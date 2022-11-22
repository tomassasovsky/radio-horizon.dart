// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_garden/radio_garden.dart';
import 'package:radio_garden/src/checks.dart';

ChatGroup music = ChatGroup(
  'music',
  'Music related commands',
  checks: [
    GuildCheck.all(),
    userConnectedToVoiceChannelCheck,
    sameVoiceChannelOrDisconnectedCheck,
  ],
  children: [
    ChatCommand(
      'play',
      'Plays music based on the given query',
      id('music-play', (
        IChatContext context,
        @Description('The name/url of the song/playlist to play')
        @Autocomplete(_autocompleteCallback)
            String query,
      ) async {
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
          await context
              .respond(MessageBuilder.content('No results were found'));
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
              'Playlist `${result.playlistInfo.name}`($query) enqueued',
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
              'Track `${result.tracks[0].info?.title}` enqueued',
            ),
          );
        }

        SongRecognitionService.instance
            .deleteRadioFromList(context.guild!.id.toString());
      }),
    ),
    ChatCommand(
      'skip',
      'Skips the currently playing track',
      checks: [connectedToAVoiceChannelCheck],
      id('music-skip', (IChatContext context) async {
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
          await context.respond(MessageBuilder.content('The queue is clear!'));
          return;
        }

        node.skip(context.guild!.id);
        await context.respond(MessageBuilder.content('Skipped current track'));
      }),
    ),
    ChatCommand(
      'stop',
      'Stops the current player and clears its track queue',
      checks: [connectedToAVoiceChannelCheck],
      id('music-stop', (IChatContext context) async {
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
        await context.respond(MessageBuilder.content('Player stopped!'));
      }),
    ),
    ChatCommand(
      'leave',
      'Leaves the current voice channel',
      checks: [connectedToAVoiceChannelCheck],
      id('music-leave', (IChatContext context) async {
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
        await context.respond(MessageBuilder.content('Channel left'));
      }),
    ),
    ChatCommand(
      'join',
      'Joins the voice channel you are in',
      checks: [notConnectedToAVoiceChannelCheck],
      id('music-join', (IChatContext context) async {
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
            .respond(MessageBuilder.content('Joined your voice channel'));
      }),
    ),
    ChatCommand(
      'volume',
      'Sets the volume for the player',
      checks: [connectedToAVoiceChannelCheck],
      id('music-volume', (
        IChatContext context,
        @Description(
          'The new volume, this value must be contained between 0 and 1000',
        )
        @UseConverter(IntConverter(min: 0, max: 1000))
            int volume,
      ) async {
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

        await context
            .respond(MessageBuilder.content('Volume changed to $volume'));
      }),
    ),
    ChatCommand(
      'pause',
      'Pauses the player',
      id('music-pause', (IChatContext context) async {
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
        await context.respond(MessageBuilder.content('Player paused'));
      }),
    ),
    ChatCommand(
      'resume',
      'Resumes the currently playing track',
      id('music-resume', (IChatContext context) async {
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
        await context.respond(MessageBuilder.content('Player resumed'));
      }),
    ),
  ],
);

FutureOr<Iterable<ArgChoiceBuilder>?> _autocompleteCallback(
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
