// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:radio_garden/radio_garden.dart';
import 'package:radio_garden/src/checks.dart';
import 'package:radio_garden/src/models/radio_garden_response.dart';

ChatGroup radio = ChatGroup(
  'radio',
  'Radio related commands',
  checks: [
    GuildCheck.all(),
    userConnectedToVoiceChannelCheck,
    sameVoiceChannelOrDisconnectedCheck,
  ],
  children: [
    ChatCommand(
      'play',
      'Plays music from the specified radio station',
      id('radio-play', (
        IChatContext context,
        @Description('The name of the Radio Station to play') String query,
      ) async {
        final node = MusicService.instance.cluster
            .getOrCreatePlayerNode(context.guild!.id);
        await connectIfNeeded(context);

        final radio = await radioByName(query);

        if (radio == null || (radio.hits?.hits?.isEmpty ?? true)) {
          await context
              .respond(MessageBuilder.content('No results were found'));
          return;
        }

        final result = await node.searchTracks(radio.uri!);
        if (result.tracks.isEmpty) {
          await context
              .respond(MessageBuilder.content('We could not find that track'));
          return;
        }

        final track = result.tracks.first;

        node
            .play(
              context.guild!.id,
              track,
              requester: context.member!.id,
              channelId: context.channel.id,
            )
            .startPlaying();
        await context.respond(
          MessageBuilder.content(
            'Playlist `${track.info?.title}`($query) enqueued',
          ),
        );
      }),
    ),
  ],
);

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
