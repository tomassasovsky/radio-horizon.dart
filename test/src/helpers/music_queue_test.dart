import 'dart:async';

import 'package:mocktail/mocktail.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_horizon/src/helpers/music_queue.dart';
import 'package:test/test.dart';

class _MockLavalinkPlayer extends Mock implements LavalinkPlayer {}

class _FakeTrack extends Fake implements Track {}

class _FakeTrackEndEvent extends Fake implements TrackEndEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeTrack());
  });

  group(MusicQueue, () {
    late _MockLavalinkPlayer player;
    late StreamController<TrackEndEvent> trackEnd;
    late MusicQueue queue;

    setUp(() {
      player = _MockLavalinkPlayer();
      trackEnd = StreamController<TrackEndEvent>.broadcast();
      when(() => player.onTrackEnd).thenAnswer((_) => trackEnd.stream);
      when(() => player.stopPlaying()).thenAnswer((_) async {});
      when(() => player.play(any())).thenAnswer((_) async {});
      queue = MusicQueue(player);
    });

    tearDown(() async {
      await trackEnd.close();
    });

    group('discard', () {
      test('does not stop the Lavalink player', () {
        queue.discard();

        verifyNever(() => player.stopPlaying());
      });

      test('does not stop the player on a later track end', () async {
        queue.queueTrack(_FakeTrack());
        queue.discard();

        trackEnd.add(_FakeTrackEndEvent());
        await Future<void>.delayed(Duration.zero);

        verifyNever(() => player.stopPlaying());
      });
    });

    group('clear', () {
      test('stops the Lavalink player', () {
        queue.clear();

        verify(() => player.stopPlaying()).called(1);
      });
    });

    group('track end', () {
      test('stops the player when the queue is empty', () async {
        queue.queueTrack(_FakeTrack());

        trackEnd.add(_FakeTrackEndEvent());
        await Future<void>.delayed(Duration.zero);

        verify(() => player.stopPlaying()).called(1);
      });
    });
  });
}
