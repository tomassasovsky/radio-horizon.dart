// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:math' as math;

import 'package:injector/injector.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:radio_horizon/src/checks.dart';
import 'package:radio_horizon/src/helpers/music_queue.dart';

final _enMusicCommand = AppLocale.en.translations.commands.music;
final _enPlayCommand = _enMusicCommand.children.play;

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
      id(
        'music-play',
        (
          ChatContext context,
          @Description('The name/url of the song/playlist to play')
          @Autocomplete(autocompleteMusicQuery)
          String query,
        ) =>
            musicPlay(
          context: context,
          query: query,
          source: 'ytsearch',
        ),
      ),
      localizedDescriptions: localizedValues(
        (translations) => translations.commands.music.children.play.description,
      ),
      localizedNames: localizedValues(
        (translations) => translations.commands.music.children.play.command,
      ),
    ),
    ChatCommand(
      'ytplay',
      'Search for a song on YouTube',
      id(
        'music-play-youtube',
        (
          ChatContext context,
          @Description('The name of the song to play')
          @Autocomplete(autocompleteMusicYoutubeQuery)
          String query,
        ) =>
            musicPlay(
          context: context,
          query: query,
          source: 'ytsearch',
        ),
      ),
      localizedDescriptions: localizedValues(
        (translations) => translations
            .commands.music.children.play.children.youtube.description,
      ),
      localizedNames: localizedValues(
        (translations) =>
            translations.commands.music.children.play.children.youtube.command,
      ),
    ),
    ChatCommand(
      'dzplay',
      'Search for a song on Deezer',
      id(
        'music-play-deezer',
        (
          ChatContext context,
          @Description('The name of the song to play')
          @Autocomplete(autocompleteMusicDeezerQuery)
          String query,
        ) =>
            musicPlay(
          context: context,
          query: query,
          source: 'dzsearch',
        ),
      ),
      localizedDescriptions: localizedValues(
        (translations) => translations
            .commands.music.children.play.children.deezer.description,
      ),
      localizedNames: localizedValues(
        (translations) =>
            translations.commands.music.children.play.children.deezer.command,
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

FutureOr<Iterable<CommandOptionChoiceBuilder<String>>?>
    autocompleteMusicYoutubeQuery(AutocompleteContext context) async {
  return autocompleteMusicQuery(context, sources: ['ytmsearch']);
}

FutureOr<Iterable<CommandOptionChoiceBuilder<String>>?>
    autocompleteMusicDeezerQuery(AutocompleteContext context) async {
  return autocompleteMusicQuery(context, sources: ['dzsearch']);
}

FutureOr<Iterable<CommandOptionChoiceBuilder<String>>?> autocompleteMusicQuery(
  AutocompleteContext context, {
  List<String> sources = const ['ytmsearch', 'dzsearch'],
}) async {
  final query = context.currentValue;
  if (query.isEmpty) {
    return null;
  }

  final lavalinkClient = Injector.appInstance.get<LavalinkClient>();
  final responses = <SearchLoadResult>[];
  for (final source in sources) {
    final response = await lavalinkClient.loadTrack('$source:$query');
    if (response is SearchLoadResult) {
      responses.add(response);
    }
  }

  // Extract the data lists from responses
  final tracksLists = responses.map((response) => response.data).toList();

  // Interleave the tracks
  final interleavedTracks = <Track>[];
  final iterators = tracksLists.map((list) => list.iterator).toList();

  var hasNext = true;

  while (hasNext && interleavedTracks.length < 25) {
    hasNext = false;
    for (final iterator in iterators) {
      if (iterator.moveNext()) {
        interleavedTracks.add(iterator.current);
        hasNext = true;
        if (interleavedTracks.length >= 25) break;
      }
    }
  }

  // Convert the tracks to CommandOptionChoiceBuilder<String>
  final choices = interleavedTracks.map((track) {
    final name = track.info.title;
    final artist = track.info.author;
    final title = '$name by $artist';
    final source = track.info.sourceName;
    final value = track.info.uri.toString();

    return CommandOptionChoiceBuilder<String>(
      name:
          // ignore: lines_longer_than_80_chars
          '${title.substring(0, math.min(title.length, 100 - source.length - 3))} '
          '($source)',
      value: value.substring(0, math.min(value.length, 100)),
    );
  });

  return choices;
}

Future<void> musicPlay({
  required ChatContext context,
  required String query,
  required String source,
}) async {
  context as InteractionChatContext;

  final commandTranslations =
      getCommandTranslations(context).music.children.play;

  final player = await connectLavalink(context);
  if (player == null) {
    await context.respond(
      MessageBuilder(content: commandTranslations.noResults(query: query)),
    );
    return;
  }

  LoadResult searchResult;

  final queryAsUri = Uri.tryParse(query);
  final isUrl = queryAsUri != null && queryAsUri.hasScheme;
  if (isUrl) {
    searchResult = await player.lavalinkClient.loadTrack(query);
  } else {
    searchResult = await player.lavalinkClient.loadTrack('$source:$query');
  }

  if (searchResult is SearchLoadResult) {
    if (searchResult.data.isEmpty) {
      throw Exception('No tracks found');
    }

    trackQueues.getOrCreateQueue(player).queueTrack(searchResult.data.first);

    await context.respond(
      MessageBuilder(
        content: commandTranslations.songEnqueued(
          title: searchResult.data.first.info.title,
          query: query,
        ),
      ),
    );
  } else if (searchResult is TrackLoadResult) {
    trackQueues.getOrCreateQueue(player).queueTrack(searchResult.data);

    await context.respond(
      MessageBuilder(
        content: commandTranslations.songEnqueued(
          title: searchResult.data.info.title,
          query: query,
        ),
      ),
    );
  } else if (searchResult is PlaylistLoadResult) {
    if (searchResult.data.tracks.isEmpty) {
      throw Exception('No tracks found');
    }

    final tracks = searchResult.data.tracks;
    trackQueues.getOrCreateQueue(player).queueTracks(tracks);

    await context.respond(
      MessageBuilder(
        content: commandTranslations.playlistEnqueued(
          name: searchResult.data.info.name,
          query: query,
        ),
      ),
    );
  } else {
    throw Exception(
      // ignore: lines_longer_than_80_chars, avoid_dynamic_calls
      'Unknown load result: $searchResult, ${searchResult.data.runtimeType}',
    );
  }

  await Injector.appInstance
      .get<DatabaseService>()
      .deleteRadioFromList(context.guild!.id);
}
