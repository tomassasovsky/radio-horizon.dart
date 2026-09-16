import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:nyxx/nyxx.dart' hide Request;
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/src/models/song_recognition/guild_radio.dart';
import 'package:radio_horizon/src/services/activity_bind.dart';
import 'package:radio_horizon/src/services/activity_http.dart';
import 'package:radio_horizon/src/services/playback.dart';
import 'package:shazam_client/shazam_client.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

class _MockHttp extends Mock implements http.Client {}

class _MockRadio extends Mock implements RadioBrowserApi {}

class _MockLavalink extends Mock implements LavalinkClient {}

class _MockPlayer extends Mock implements LavalinkPlayer {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('https://discord.com/api/v10'));
    registerFallbackValue(<String, String>{});
    registerFallbackValue(<String>[]);
    registerFallbackValue(
      Track(
        encoded: 'enc',
        info: TrackInfo(
          identifier: 'id',
          isSeekable: true,
          author: 'a',
          length: Duration.zero,
          isStream: true,
          position: Duration.zero,
          title: 't',
          uri: Uri.parse('https://example.com'),
          artworkUrl: null,
          isrc: null,
          sourceName: 'http',
        ),
        pluginInfo: const {},
        userData: const {},
      ),
    );
  });

  const guildId = Snowflake(1);
  const channelId = Snowflake(2);
  const userId = Snowflake(10);

  late _MockHttp discord;
  late _MockRadio radioBrowser;
  late _MockLavalink lavalink;
  late _MockPlayer player;
  late List<GuildRadio> saved;
  late Handler handler;

  setUp(() {
    discord = _MockHttp();
    radioBrowser = _MockRadio();
    lavalink = _MockLavalink();
    player = _MockPlayer();
    saved = [];

    when(() => player.guildId).thenReturn(guildId);
    when(() => player.onTrackEnd)
        .thenAnswer((_) => const Stream<TrackEndEvent>.empty());
    when(() => player.play(any())).thenAnswer((_) async {});
    when(() => player.stopPlaying()).thenAnswer((_) async {});
    when(() => player.disconnect()).thenAnswer((_) async {});

    when(
      () => discord.get(any(), headers: any(named: 'headers')),
    ).thenAnswer((invocation) async {
      final uri = invocation.positionalArguments.first as Uri;
      if (uri.path.endsWith('/users/@me')) {
        return http.Response(jsonEncode({'id': userId.toString()}), 200);
      }
      return http.Response(
        jsonEncode({
          'location': {
            'kind': 'gc',
            'guild_id': guildId.toString(),
            'channel_id': channelId.toString(),
          },
          'users': [userId.toString()],
        }),
        200,
      );
    });

    when(
      () => discord.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response('fail', 400));

    final bind = ActivityBindService(
      httpClient: discord,
      clientId: 'app',
      clientSecret: 'secret',
      botToken: 'bot',
      userVoiceChannel: (guild, user) =>
          guild == guildId && user == userId ? channelId : null,
      isGuildVoice: (guild, channel) =>
          guild == guildId && channel == channelId,
      discordApiBase: Uri.parse('https://discord.com/api/v10'),
    );

    final playback = PlaybackService(
      loadRadio: (_) async => null,
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
      clearRadio: (_) async {},
      connect: (_, __) async => player,
      botChannelId: (_) => null,
      loadTrack: (_) async => TrackLoadResult(
        loadType: 'track',
        data: _track(),
      ),
      identify: (_, __) async => SongModel(title: 'x'),
      clickStation: (_) async {},
      voteStation: (_) async {},
      queues: {},
    );

    handler = ActivityHttpService(
      bind: bind,
      playback: playback,
      lavalink: lavalink,
      radioBrowser: radioBrowser,
      port: 8080,
    ).handler;
  });

  Future<Response> call(
    String method,
    String path, {
    Map<String, String>? headers,
    String? body,
  }) {
    return Future.value(
      handler(
        Request(
          method,
          Uri.parse('http://localhost$path'),
          headers: headers,
          body: body,
        ),
      ),
    );
  }

  group(ActivityHttpService, () {
    test('GET /healthz returns 200', () async {
      final response = await call('GET', '/healthz');
      expect(response.statusCode, equals(200));
    });

    test('token exchange failure does not crash', () async {
      final response = await call(
        'POST',
        '/api/token',
        body: jsonEncode({'code': 'bad'}),
      );
      expect(response.statusCode, equals(401));
      expect(
        jsonDecode(await response.readAsString()),
        equals({'error': 'unauthorized'}),
      );
    });

    test('invalid Bearer returns 401', () async {
      when(
        () => discord.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('{}', 401));

      final response = await call(
        'POST',
        '/api/stop',
        headers: {
          'Authorization': 'Bearer bad',
          'X-Discord-Instance-Id': 'inst',
        },
      );
      expect(response.statusCode, equals(401));
    });

    test('play uses the bound instance channel, not a client guild id',
        () async {
      when(
        () => radioBrowser.getStationsByUUID(uuids: any(named: 'uuids')),
      ).thenAnswer(
        (_) async => RadioBrowserListResponse(
          error: '',
          limit: 1,
          offset: 0,
          pages: 1,
          totalResults: 1,
          statusCode: 200,
          items: [_station()],
          version: '',
          hidebroken: false,
        ),
      );

      final response = await call(
        'POST',
        '/api/play/radio',
        headers: {
          'Authorization': 'Bearer tok',
          'X-Discord-Instance-Id': 'inst',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'stationUuid': 'station',
          'guildId': '999',
          'channelId': '888',
        }),
      );

      expect(response.statusCode, equals(200));
      expect(saved, hasLength(1));
      expect(saved.single.guildId, equals(guildId));
      expect(saved.single.voiceChannelId, equals(channelId));
      expect(saved.single.textChannelId, equals(channelId));
    });
  });
}

Track _track() {
  return Track(
    encoded: 'enc',
    info: TrackInfo(
      identifier: 'id',
      isSeekable: true,
      author: 'a',
      length: const Duration(seconds: 1),
      isStream: true,
      position: Duration.zero,
      title: 'stream',
      uri: Uri.parse('https://example.com'),
      artworkUrl: null,
      isrc: null,
      sourceName: 'http',
    ),
    pluginInfo: const {},
    userData: const {},
  );
}

Station _station() {
  return Station(
    changeUUID: 'change',
    stationUUID: 'station',
    serverUUID: 'server',
    name: 'Station A',
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
