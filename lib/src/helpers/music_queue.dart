import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';

final trackQueues = <Snowflake, MusicQueue>{};

class MusicQueue {
  MusicQueue(this.player) {
    player.onTrackEnd.listen((event) {
      _playNext();
    });
  }

  final LavalinkPlayer player;
  final List<Track> _queue = [];
  bool _isPlaying = false;

  void queueTrack(Track track) {
    _queue.add(track);
    if (!_isPlaying) {
      _playNext();
    }
  }

  void queueTracks(List<Track> tracks) {
    _queue.addAll(tracks);
    if (!_isPlaying) {
      _playNext();
    }
  }

  void clear() {
    _queue.clear();
    player.stopPlaying();
    _isPlaying = false;
  }

  /// Skip the current track and play the next one.
  /// Returns the next track that will be played.
  Track? skip() {
    // this will trigger the onTrackEnd event
    final nextTrack = _queue.elementAtOrNull(0);
    player.stopPlaying();
    return nextTrack;
  }

  void _playNext() {
    if (_queue.isNotEmpty) {
      final nextTrack = _queue.removeAt(0);
      player.play(nextTrack);
      _isPlaying = true;
    } else {
      player.stopPlaying();
      _isPlaying = false;
    }
  }

  bool get isEmpty => _queue.isEmpty;
  bool get isPlaying => _isPlaying;
}

extension QueueHelper on Map<Snowflake, MusicQueue> {
  MusicQueue getOrCreateQueue(LavalinkPlayer player) {
    return this[player.guildId] ??= MusicQueue(player);
  }
}
