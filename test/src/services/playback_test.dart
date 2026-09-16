import 'dart:async';

import 'package:mocktail/mocktail.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/src/helpers/music_queue.dart';
import 'package:radio_horizon/src/models/song_recognition/guild_radio.dart';
import 'package:radio_horizon/src/services/playback.dart';
import 'package:radio_horizon/src/services/playback_session.dart';
import 'package:shazam_client/shazam_client.dart';
import 'package:test/test.dart';

class _MockLavalinkPlayer extends Mock implements LavalinkPlayer {}

class _FakeTrack extends Fake implements Track {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeTrack());
  });

  const guildId = Snowflake(1);
  const voiceChannelId = Snowflake(2);
  const otherChannelId = Snowflake(99);
  const textChannelId = Snowflake(3);

  late _MockLavalinkPlayer player;
  late StreamController<TrackEndEvent> trackEnd;
  late Map<Snowflake, MusicQueue> queues;
  late List<String> clicked;
  late List<String> voted;
  late List<GuildRadio> saved;
  late int cleared;
  late int connectCalls;
  late Snowflake? botChannel;
  late GuildRadio? radio;
  late LoadResult? loadResult;
  late int identifyCalls;
  late PlaybackService service;

  PlaybackService buildService() {
    return PlaybackService(
      loadRadio: (_) async => radio,
      saveRadio: (guild, voice, text, station) async {
        saved.add(
          GuildRadio(
            guild,
            voiceChannelId: voice,
            textChannelId: text,
            station: station,
          ),
        );
      },
      clearRadio: (_) async {
        cleared++;
        radio = null;
      },
      connect: (guild, channel) async {
        connectCalls++;
        return player;
      },
      botChannelId: (_) => botChannel,
      loadTrack: (_) async => loadResult!,
      identify: (_, __) async {
        identifyCalls++;
        return SongModel(title: 'Identified');
      },
      clickStation: (uuid) async => clicked.add(uuid),
      voteStation: (uuid) async => voted.add(uuid),
      queues: queues,
    );
  }

  setUp(() {
    player = _MockLavalinkPlayer();
    trackEnd = StreamController<TrackEndEvent>.broadcast();
    queues = {};
    clicked = [];
    voted = [];
    saved = [];
    cleared = 0;
    connectCalls = 0;
    botChannel = null;
    radio = null;
    loadResult = TrackLoadResult(loadType: 'track', data: _track('stream'));
    identifyCalls = 0;

    when(() => player.guildId).thenReturn(guildId);
    when(() => player.onTrackEnd).thenAnswer((_) => trackEnd.stream);
    when(() => player.play(any())).thenAnswer((_) async {});
    when(() => player.setVolume(any())).thenAnswer((_) async {});
    when(() => player.stopPlaying()).thenAnswer((_) async {});
    when(() => player.currentTrack).thenReturn(null);
    when(() => player.disconnect()).thenAnswer((_) async {});

    service = buildService();
  });

  tearDown(() async {
    await trackEnd.close();
  });

  group(PlaybackService, () {
    group('nowPlaying', () {
      test('is idle when this guild+VC has no live player', () async {
        expect(
          (await service.nowPlaying(guildId, voiceChannelId)).kind,
          equals(PlaybackSessionKind.idle),
        );
      });

      test('uses the Radio Browser station name for radio in that VC',
          () async {
        botChannel = voiceChannelId;
        radio = _guildRadio("America's Greatest 80s Hits");
        when(() => player.currentTrack).thenReturn(_track('stream title'));
        queues.getOrCreateQueue(player);

        final session = await service.nowPlaying(guildId, voiceChannelId);

        expect(session.kind, equals(PlaybackSessionKind.radio));
        expect(session.stationName, equals("America's Greatest 80s Hits"));
      });

      test('uses currentTrack title, not MusicQueue front, for music',
          () async {
        botChannel = voiceChannelId;
        final queue = queues.getOrCreateQueue(player);
        queue.queueTrack(_track('Queued Song'));
        when(() => player.currentTrack).thenReturn(_track('Hey Jude'));

        final session = await service.nowPlaying(guildId, voiceChannelId);

        expect(session.kind, equals(PlaybackSessionKind.music));
        expect(session.trackTitle, equals('Hey Jude'));
      });
    });

    group('playRadio', () {
      test('clicks, plays, and saves the station', () async {
        botChannel = voiceChannelId;
        queues.getOrCreateQueue(player).queueTrack(_track('Old song'));

        final outcome = await service.playRadio(
          guildId,
          voiceChannelId,
          station: _station("America's Greatest 80s Hits"),
          textChannelId: textChannelId,
        );

        expect(outcome.isSuccess, isTrue);
        expect(clicked, equals(['station']));
        expect(saved, hasLength(1));
        expect(
          saved.single.station.name,
          equals("America's Greatest 80s Hits"),
        );
        verify(() => player.play(any())).called(greaterThanOrEqualTo(1));
      });

      test('returns lavalinkUnavailable when load is not a track', () async {
        botChannel = voiceChannelId;
        loadResult = EmptyLoadResult(loadType: 'empty');

        final outcome = await service.playRadio(
          guildId,
          voiceChannelId,
          station: _station('Station A'),
          textChannelId: textChannelId,
        );

        expect(outcome.error, equals(PlaybackError.lavalinkUnavailable));
        expect(saved, isEmpty);
      });
    });

    group('enqueueTracks', () {
      test('clears radio and queues the tracks', () async {
        botChannel = voiceChannelId;
        radio = _guildRadio('Station A');
        final track = _track('Hey Jude');

        final outcome =
            await service.enqueueTracks(guildId, voiceChannelId, [track]);

        expect(outcome.isSuccess, isTrue);
        expect(outcome.nextTrack, same(track));
        expect(cleared, equals(1));
        verify(() => player.play(track)).called(1);
      });

      test('returns notPlaying for an empty list', () async {
        botChannel = voiceChannelId;

        expect(
          (await service.enqueueTracks(guildId, voiceChannelId, const []))
              .error,
          equals(PlaybackError.notPlaying),
        );
      });
    });

    group('skip', () {
      test('returns nothingToSkip on radio and does not stop the station',
          () async {
        botChannel = voiceChannelId;
        radio = _guildRadio('Station A');
        queues.getOrCreateQueue(player);

        final outcome = await service.skip(guildId, voiceChannelId);

        expect(outcome.error, equals(PlaybackError.nothingToSkip));
        verifyNever(() => player.stopPlaying());
      });

      test('plays the next queued track', () async {
        botChannel = voiceChannelId;
        final next = _track('Next');
        final queue = queues.getOrCreateQueue(player);
        queue.queueTrack(_track('Current'));
        queue.queueTrack(next);

        final outcome = await service.skip(guildId, voiceChannelId);

        expect(outcome.isSuccess, isTrue);
        expect(outcome.nextTrack, same(next));
        verify(() => player.stopPlaying()).called(1);
      });
    });

    group('stop', () {
      test('clears the queue and radio row and does not disconnect voice',
          () async {
        botChannel = voiceChannelId;
        radio = _guildRadio('Station A');
        queues.getOrCreateQueue(player).queueTrack(_track('Song'));

        final outcome = await service.stop(guildId, voiceChannelId);

        expect(outcome.isSuccess, isTrue);
        expect(queues[guildId]!.isEmpty, isTrue);
        expect(cleared, equals(1));
        verify(() => player.stopPlaying()).called(greaterThanOrEqualTo(1));
        verifyNever(() => player.disconnect());
      });

      test('stops Lavalink when no MusicQueue exists yet', () async {
        botChannel = voiceChannelId;
        radio = _guildRadio('Station A');

        final outcome = await service.stop(guildId, voiceChannelId);

        expect(outcome.isSuccess, isTrue);
        expect(cleared, equals(1));
        expect(connectCalls, equals(1));
        verify(() => player.stopPlaying()).called(1);
        verifyNever(() => player.disconnect());
      });
    });

    group('setVolume', () {
      test('clamps 0-100 and sends Lavalink volume * 10', () async {
        botChannel = voiceChannelId;
        queues.getOrCreateQueue(player);

        await service.setVolume(guildId, voiceChannelId, 50);
        await service.setVolume(guildId, voiceChannelId, -4);
        await service.setVolume(guildId, voiceChannelId, 250);

        verify(() => player.setVolume(500)).called(1);
        verify(() => player.setVolume(0)).called(1);
        verify(() => player.setVolume(1000)).called(1);
      });
    });

    group('voice gate', () {
      test('mutations no-op when the bot is in a different voice channel',
          () async {
        botChannel = otherChannelId;
        radio = _guildRadio('Station A');

        expect(
          (await service.playRadio(
            guildId,
            voiceChannelId,
            station: _station('Station A'),
            textChannelId: textChannelId,
          ))
              .error,
          equals(PlaybackError.wrongVoiceChannel),
        );
        expect(
          (await service.skip(guildId, voiceChannelId)).error,
          equals(PlaybackError.wrongVoiceChannel),
        );
        expect(
          (await service.stop(guildId, voiceChannelId)).error,
          equals(PlaybackError.wrongVoiceChannel),
        );
        expect(
          (await service.setVolume(guildId, voiceChannelId, 20)).error,
          equals(PlaybackError.wrongVoiceChannel),
        );
        expect(connectCalls, equals(0));
        expect(clicked, isEmpty);
        expect(saved, isEmpty);
        expect(cleared, equals(0));
        expect(
          (await service.enqueueTracks(
            guildId,
            voiceChannelId,
            [_track('Hey Jude')],
          ))
              .error,
          equals(PlaybackError.wrongVoiceChannel),
        );
        expect(
          (await service.recognize(guildId, voiceChannelId)).error,
          equals(PlaybackError.wrongVoiceChannel),
        );
        expect(
          (await service.upvote(guildId, voiceChannelId)).error,
          equals(PlaybackError.wrongVoiceChannel),
        );
        expect(identifyCalls, equals(0));
        expect(voted, isEmpty);
      });
    });

    group('recognize and upvote', () {
      test('return radioOnly without a GuildRadio', () async {
        botChannel = voiceChannelId;

        expect(
          (await service.recognize(guildId, voiceChannelId)).error,
          equals(PlaybackError.radioOnly),
        );
        expect(
          (await service.upvote(guildId, voiceChannelId)).error,
          equals(PlaybackError.radioOnly),
        );
        expect(identifyCalls, equals(0));
        expect(voted, isEmpty);
      });

      test('recognize returns the bound station song', () async {
        botChannel = voiceChannelId;
        radio = _guildRadio('Station A');

        final outcome = await service.recognize(guildId, voiceChannelId);

        expect(outcome.isSuccess, isTrue);
        expect(outcome.song?.title, equals('Identified'));
        expect(outcome.radio?.station.name, equals('Station A'));
        expect(identifyCalls, equals(1));
      });

      test('upvote votes the bound Mongo station', () async {
        botChannel = voiceChannelId;
        radio = _guildRadio('Station A');

        final outcome = await service.upvote(guildId, voiceChannelId);

        expect(outcome.isSuccess, isTrue);
        expect(voted, equals(['station']));
      });
    });
  });
}

Track _track(String title) {
  return Track(
    encoded: 'enc-$title',
    info: TrackInfo(
      identifier: title,
      isSeekable: true,
      author: 'artist',
      length: const Duration(minutes: 3),
      isStream: false,
      position: Duration.zero,
      title: title,
      uri: Uri.parse('https://example.com/$title'),
      artworkUrl: null,
      isrc: null,
      sourceName: 'youtube',
    ),
    pluginInfo: const {},
    userData: const {},
  );
}

Station _station(String name) {
  return Station(
    changeUUID: 'change',
    stationUUID: 'station',
    serverUUID: 'server',
    name: name,
    url: 'https://example.com/stream',
    urlResolved: 'https://example.com/stream',
    homepage: null,
    favicon: null,
    tags: null,
    country: 'US',
    countryCode: 'US',
    state: null,
    language: null,
    languageCodes: null,
    votes: 0,
    lastChangeTime: DateTime.utc(2026),
    codec: null,
    bitrate: 128,
    hls: false,
    lastCheckOk: true,
    lastCheckTime: null,
    lastCheckOkTime: null,
    lastLocalCheckTime: null,
    clickTimestamp: null,
    clickCount: 0,
    clickTrend: 0,
    sslError: false,
    geoLat: null,
    geoLong: null,
    hasExtendedInfo: false,
  );
}

GuildRadio _guildRadio(
  String name, {
  Snowflake voiceChannelId = const Snowflake(2),
}) {
  return GuildRadio(
    const Snowflake(1),
    voiceChannelId: voiceChannelId,
    textChannelId: const Snowflake(3),
    station: _station(name),
  );
}
