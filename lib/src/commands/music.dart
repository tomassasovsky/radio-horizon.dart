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

final TranslationsCommandsMusicEn _enMusicCommand =
    AppLocale.en.translations.commands.music;
final TranslationsCommandsMusicChildrenPlayEn _enPlayCommand =
    _enMusicCommand.children.play;
final _logger = Logger('command/music');

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
    autocompleteMusicYoutubeQuery(AutocompleteContext context) {
  return autocompleteMusicQuery(context, sources: ['ytmsearch']);
}

FutureOr<Iterable<CommandOptionChoiceBuilder<String>>?>
    autocompleteMusicDeezerQuery(AutocompleteContext context) {
  return autocompleteMusicQuery(context, sources: ['dzsearch']);
}

FutureOr<Iterable<CommandOptionChoiceBuilder<String>>?> autocompleteMusicQuery(
  AutocompleteContext context, {
  List<String> sources = const ['ytmsearch'],
}) async {
  final query = context.currentValue;
  if (query.isEmpty) {
    return null;
  }

  final lavalinkClient = Injector.appInstance.get<LavalinkClient>();
  final responses = <SearchLoadResult>[];
  for (final source in sources) {
    final response = await _loadSearchResults(lavalinkClient, source, query);
    if (response != null) {
      responses.add(response);
    }
  }

  if (responses.isEmpty &&
      sources.contains('ytmsearch') &&
      !sources.contains('ytsearch')) {
    final fallback =
        await _loadSearchResults(lavalinkClient, 'ytsearch', query);
    if (fallback != null) {
      responses.add(fallback);
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
    final displayTitle = title.substring(
      0,
      math.min(title.length, 100 - source.length - 3),
    );

    return CommandOptionChoiceBuilder<String>(
      name: '$displayTitle ($source)',
      value: value.substring(0, math.min(value.length, 100)),
    );
  });

  return choices;
}

Future<SearchLoadResult?> _loadSearchResults(
  LavalinkClient lavalinkClient,
  String source,
  String query,
) async {
  try {
    final response = await lavalinkClient.loadTrack('$source:$query');
    if (response is SearchLoadResult && response.data.isNotEmpty) {
      return response;
    }

    if (response is ErrorLoadResult) {
      _logger.warning(
        'Failed to autocomplete "$query" via $source: '
        '${_loadErrorDescription(response)}',
      );
    }
  } on Object catch (error, stackTrace) {
    _logger.warning(
      'Failed to autocomplete "$query" via $source',
      error,
      stackTrace,
    );
  }

  return null;
}

Future<void> musicPlay({
  required ChatContext context,
  required String query,
  required String source,
}) async {
  context as InteractionChatContext;

  final commandTranslations =
      getCommandTranslations(context).music.children.play;

  final lavalinkClient = Injector.appInstance.get<LavalinkClient>();
  final queryAsUri = Uri.tryParse(query);
  final isUrl = queryAsUri != null && queryAsUri.hasScheme;
  final searchResult = await lavalinkClient.loadTrack(
    isUrl ? query : '$source:$query',
  );

  late final List<Track> tracks;
  var playlistName = query;
  if (searchResult is SearchLoadResult) {
    tracks = searchResult.data.isEmpty ? const [] : [searchResult.data.first];
  } else if (searchResult is TrackLoadResult) {
    tracks = [searchResult.data];
  } else if (searchResult is PlaylistLoadResult) {
    tracks = searchResult.data.tracks;
    playlistName = searchResult.data.info.name;
  } else if (searchResult is ErrorLoadResult) {
    _logger.warning(
      'Failed to load "$query": ${_loadErrorDescription(searchResult)}',
    );
    await context.respond(
      MessageBuilder(content: commandTranslations.noResults(query: query)),
    );
    return;
  } else {
    throw Exception(
      'Unknown load result: $searchResult, ${searchResult.data.runtimeType}',
    );
  }

  if (tracks.isEmpty) {
    throw Exception('No tracks found');
  }

  final outcome =
      await Injector.appInstance.get<PlaybackService>().enqueueTracks(
            context.guild!.id,
            commandVoiceChannelId(context),
            tracks,
          );
  if (!outcome.isSuccess) {
    await context.respond(
      MessageBuilder(content: commandTranslations.noResults(query: query)),
    );
    return;
  }

  if (searchResult is PlaylistLoadResult) {
    await context.respond(
      MessageBuilder(
        content: commandTranslations.playlistEnqueued(
          name: playlistName,
          query: query,
        ),
      ),
    );
    return;
  }

  await context.respond(
    MessageBuilder(
      content: commandTranslations.songEnqueued(
        title: tracks.first.info.title,
        query: query,
      ),
    ),
  );
}

String _loadErrorDescription(ErrorLoadResult result) {
  final message = result.data.message ?? 'unknown error';
  final cause = result.data.cause.trim();
  if (cause.isEmpty) {
    return message;
  }
  return '$message ($cause)';
}
