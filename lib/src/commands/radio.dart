// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_garden/radio_garden.dart';
import 'package:radio_garden/src/checks.dart';
import 'package:radio_garden/src/models/radio_garden_response.dart';
import 'package:radio_garden/src/services/song_recognition.dart';
import 'package:radio_garden/src/util.dart';

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
        @Description('The name of the Radio Station to play')
        @Autocomplete(_autocompleteCallback)
            String query,
      ) async {
        await connectIfNeeded(context, replace: true);

        final node = MusicService.instance.cluster
            .getOrCreatePlayerNode(context.guild!.id);

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
          ..players[context.guild!.id]!.queue.clear()
          ..play(
            context.guild!.id,
            track,
            replace: true,
            requester: context.member!.id,
            channelId: context.channel.id,
          ).startPlaying();

        SongRecognitionService.instance.currentRadio = radio;

        final embed = EmbedBuilder()
          ..color = getRandomColor()
          ..title = 'Started playing'
          ..description = 'Radio ${radio.title} '
              'started playing.\n\nRequested by ${context.member?.mention}';

        await context.respond(MessageBuilder.embed(embed));
      }),
    ),
    ChatCommand(
      'recognise',
      'Recognise the current song playing',
      id('music-recognise', (
        IChatContext context,
      ) async {
        try {
          final radioId = SongRecognitionService.instance.currentRadio.radioId;

          final result =
              await SongRecognitionService.instance.identify(radioId);
          await context.respond(MessageBuilder.content(result));
        } catch (_) {
          await context.respond(
            MessageBuilder.content(
              "Couldn't identify the current song playing :(",
            ),
          );
        }
      }),
    ),
  ],
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
