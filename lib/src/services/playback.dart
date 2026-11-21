// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/src/helpers/music_queue.dart';
import 'package:radio_horizon/src/models/song_recognition/guild_radio.dart';
import 'package:radio_horizon/src/services/db.dart';
import 'package:radio_horizon/src/services/playback_session.dart';
import 'package:radio_horizon/src/services/song_recognition.dart';
import 'package:retry/retry.dart';
import 'package:shazam_client/shazam_client.dart';

enum PlaybackError {
  nothingToSkip,
  radioOnly,
  lavalinkUnavailable,
  wrongVoiceChannel,
  notPlaying,
}

class PlaybackResult {
  const PlaybackResult.success({
    this.nextTrack,
    this.radio,
    this.song,
  }) : error = null;

  const PlaybackResult.failure(this.error)
      : nextTrack = null,
        radio = null,
        song = null;

  final PlaybackError? error;
  final Track? nextTrack;
  final GuildRadio? radio;
  final SongModel? song;

  bool get isSuccess => error == null;
}

typedef LoadRadio = Future<GuildRadio?> Function(Snowflake guildId);
typedef SaveRadio = Future<void> Function(
  Snowflake guildId,
  Snowflake voiceChannelId,
  Snowflake textChannelId,
  Station station,
);
typedef ClearRadio = Future<void> Function(Snowflake guildId);
typedef ConnectToVoice = Future<LavalinkPlayer?> Function(
  Snowflake guildId,
  Snowflake voiceChannelId,
);
typedef BotVoiceChannel = Snowflake? Function(Snowflake guildId);
typedef LoadTrack = Future<LoadResult> Function(String identifier);
typedef IdentifySong = Future<SongModel> Function(
  String url,
  int? durationInSeconds,
);
typedef StationAction = Future<void> Function(String uuid);

PlaybackService createPlaybackService({
  required DatabaseService database,
  required LavalinkClient lavalink,
  required SongRecognitionService recognition,
  required ConnectToVoice connect,
  required BotVoiceChannel botChannelId,
  Map<Snowflake, MusicQueue>? queues,
}) {
  const radioBrowser = RadioBrowserApi.fromHost('de1.api.radio-browser.info');
  return PlaybackService(
    loadRadio: database.getPlaying,
    saveRadio: database.setCurrentRadio,
    clearRadio: database.deleteRadioFromList,
    connect: connect,
    botChannelId: botChannelId,
    loadTrack: lavalink.loadTrack,
    queues: queues ?? trackQueues,
    identify: recognition.identify,
    clickStation: (uuid) async {
      await radioBrowser.clickStation(uuid: uuid);
    },
    voteStation: (uuid) async {
      await radioBrowser.voteForStation(stationUUID: uuid);
    },
  );
}

class PlaybackService {
  PlaybackService({
    required LoadRadio loadRadio,
    required SaveRadio saveRadio,
    required ClearRadio clearRadio,
    required ConnectToVoice connect,
    required BotVoiceChannel botChannelId,
    required LoadTrack loadTrack,
    required IdentifySong identify,
    required StationAction clickStation,
    required StationAction voteStation,
    required Map<Snowflake, MusicQueue> queues,
  })  : _loadRadio = loadRadio,
        _saveRadio = saveRadio,
        _clearRadio = clearRadio,
        _connect = connect,
        _botChannelId = botChannelId,
        _loadTrack = loadTrack,
        _identify = identify,
        _clickStation = clickStation,
        _voteStation = voteStation,
        _queues = queues;

  final LoadRadio _loadRadio;
  final SaveRadio _saveRadio;
  final ClearRadio _clearRadio;
  final ConnectToVoice _connect;
  final BotVoiceChannel _botChannelId;
  final LoadTrack _loadTrack;
  final IdentifySong _identify;
  final StationAction _clickStation;
  final StationAction _voteStation;
  final Map<Snowflake, MusicQueue> _queues;

  Future<PlaybackSession> nowPlaying(
    Snowflake guildId,
    Snowflake voiceChannelId,
  ) async {
    final radio = await _loadRadio(guildId);
    return PlaybackSession.resolve(
      voiceChannelId: voiceChannelId,
      botChannelId: _botChannelId(guildId),
      radio: radio,
      currentTrackTitle: _queues[guildId]?.player.currentTrack?.info.title,
    );
  }

  Future<PlaybackResult> playRadio(
    Snowflake guildId,
    Snowflake voiceChannelId, {
    required Station station,
    required Snowflake textChannelId,
  }) async {
    final gate = _mutationGate(guildId, voiceChannelId);
    if (gate != null) {
      return PlaybackResult.failure(gate);
    }

    try {
      await _clickStation(station.stationUUID);
      final result = await _loadTrack(station.urlResolved ?? station.url);
      if (result is! TrackLoadResult) {
        return const PlaybackResult.failure(PlaybackError.lavalinkUnavailable);
      }

      final player = await _connectToVoice(guildId, voiceChannelId);
      if (player == null) {
        return const PlaybackResult.failure(PlaybackError.lavalinkUnavailable);
      }

      _queues[guildId]?.discard();
      await player.play(result.data);
      await _saveRadio(guildId, voiceChannelId, textChannelId, station);
      return PlaybackResult.success(nextTrack: result.data);
    } on Object {
      return const PlaybackResult.failure(PlaybackError.lavalinkUnavailable);
    }
  }

  Future<PlaybackResult> playEncodedTrack(
    Snowflake guildId,
    Snowflake voiceChannelId,
    Track track,
  ) {
    return enqueueTracks(guildId, voiceChannelId, [track]);
  }

  Future<PlaybackResult> enqueueTracks(
    Snowflake guildId,
    Snowflake voiceChannelId,
    List<Track> tracks,
  ) async {
    if (tracks.isEmpty) {
      return const PlaybackResult.failure(PlaybackError.notPlaying);
    }

    final gate = _mutationGate(guildId, voiceChannelId);
    if (gate != null) {
      return PlaybackResult.failure(gate);
    }

    try {
      await _clearRadio(guildId);
      final player = await _connectToVoice(guildId, voiceChannelId);
      if (player == null) {
        return const PlaybackResult.failure(PlaybackError.lavalinkUnavailable);
      }

      _queues.getOrCreateQueue(player).queueTracks(tracks);
      return PlaybackResult.success(nextTrack: tracks.first);
    } on Object {
      return const PlaybackResult.failure(PlaybackError.lavalinkUnavailable);
    }
  }

  Future<PlaybackResult> skip(
    Snowflake guildId,
    Snowflake voiceChannelId,
  ) async {
    final gate = _requiresConnected(guildId, voiceChannelId);
    if (gate != null) {
      return PlaybackResult.failure(gate);
    }

    final queue = _queues[guildId];
    if (queue == null || queue.isEmpty) {
      return const PlaybackResult.failure(PlaybackError.nothingToSkip);
    }

    final next = queue.skip();
    return PlaybackResult.success(nextTrack: next);
  }

  Future<PlaybackResult> stop(
    Snowflake guildId,
    Snowflake voiceChannelId,
  ) async {
    final gate = _requiresConnected(guildId, voiceChannelId);
    if (gate != null) {
      return PlaybackResult.failure(gate);
    }

    final player = await _playerInChannel(guildId, voiceChannelId);
    if (player != null) {
      _queues.getOrCreateQueue(player).clear();
    }
    await _clearRadio(guildId);
    return const PlaybackResult.success();
  }

  Future<PlaybackResult> setVolume(
    Snowflake guildId,
    Snowflake voiceChannelId,
    int uiVolume0to100,
  ) {
    return setLavalinkVolume(
      guildId,
      voiceChannelId,
      uiVolume0to100.clamp(0, 100) * 10,
    );
  }

  Future<PlaybackResult> setLavalinkVolume(
    Snowflake guildId,
    Snowflake voiceChannelId,
    int volume0to1000,
  ) async {
    final gate = _requiresConnected(guildId, voiceChannelId);
    if (gate != null) {
      return PlaybackResult.failure(gate);
    }

    final player = await _playerInChannel(guildId, voiceChannelId);
    if (player == null) {
      return const PlaybackResult.failure(PlaybackError.notPlaying);
    }

    await player.setVolume(volume0to1000.clamp(0, 1000));
    return const PlaybackResult.success();
  }

  Future<PlaybackResult> recognize(
    Snowflake guildId,
    Snowflake voiceChannelId,
  ) async {
    final gate = _mutationGate(guildId, voiceChannelId);
    if (gate != null) {
      return PlaybackResult.failure(gate);
    }

    try {
      final radio = await _loadRadio(guildId);
      if (radio == null || radio.voiceChannelId != voiceChannelId) {
        return const PlaybackResult.failure(PlaybackError.radioOnly);
      }

      var recognitionSampleDuration = 10;
      SongModel? result;
      await retry(
        () async {
          result = await _identify(
            radio.station.urlResolved ?? radio.station.url,
            recognitionSampleDuration,
          );
        },
        maxDelay: const Duration(minutes: 2),
        retryIf: (_) => true,
        onRetry: (_) {
          recognitionSampleDuration +=
              (recognitionSampleDuration * 0.25).toInt();
        },
      ).timeout(const Duration(minutes: 1));

      if (result == null) {
        return const PlaybackResult.failure(PlaybackError.notPlaying);
      }

      return PlaybackResult.success(radio: radio, song: result);
    } on Object {
      return const PlaybackResult.failure(PlaybackError.notPlaying);
    }
  }

  Future<PlaybackResult> upvote(
    Snowflake guildId,
    Snowflake voiceChannelId,
  ) async {
    final gate = _mutationGate(guildId, voiceChannelId);
    if (gate != null) {
      return PlaybackResult.failure(gate);
    }

    try {
      final radio = await _loadRadio(guildId);
      if (radio == null || radio.voiceChannelId != voiceChannelId) {
        return const PlaybackResult.failure(PlaybackError.radioOnly);
      }

      await _voteStation(radio.station.stationUUID);
      return PlaybackResult.success(radio: radio);
    } on Object {
      return const PlaybackResult.failure(PlaybackError.notPlaying);
    }
  }

  PlaybackError? _mutationGate(Snowflake guildId, Snowflake voiceChannelId) {
    final botChannel = _botChannelId(guildId);
    if (botChannel != null && botChannel != voiceChannelId) {
      return PlaybackError.wrongVoiceChannel;
    }
    return null;
  }

  PlaybackError? _requiresConnected(
    Snowflake guildId,
    Snowflake voiceChannelId,
  ) {
    final gate = _mutationGate(guildId, voiceChannelId);
    if (gate != null) {
      return gate;
    }
    if (_botChannelId(guildId) == null) {
      return PlaybackError.notPlaying;
    }
    return null;
  }

  Future<LavalinkPlayer?> _playerInChannel(
    Snowflake guildId,
    Snowflake voiceChannelId,
  ) {
    final existing = _queues[guildId]?.player;
    if (existing != null) {
      return Future.value(existing);
    }
    return _connectToVoice(guildId, voiceChannelId);
  }

  Future<LavalinkPlayer?> _connectToVoice(
    Snowflake guildId,
    Snowflake voiceChannelId,
  ) {
    return _connect(guildId, voiceChannelId);
  }
}
