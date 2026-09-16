import 'package:nyxx/nyxx.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/src/models/song_recognition/guild_radio.dart';
import 'package:radio_horizon/src/services/playback_session.dart';
import 'package:test/test.dart';

void main() {
  const voiceChannelId = Snowflake(2);
  const otherChannelId = Snowflake(99);

  group(PlaybackSession, () {
    test('is idle when this guild+VC has no live player', () {
      expect(
        PlaybackSession.resolve(voiceChannelId: voiceChannelId).kind,
        equals(PlaybackSessionKind.idle),
      );
      expect(
        PlaybackSession.resolve(
          voiceChannelId: voiceChannelId,
          botChannelId: voiceChannelId,
        ).kind,
        equals(PlaybackSessionKind.idle),
      );
    });

    test('uses the Radio Browser station name when radio is live in that VC',
        () {
      final session = PlaybackSession.resolve(
        voiceChannelId: voiceChannelId,
        botChannelId: voiceChannelId,
        radio: _guildRadio("America's Greatest 80s Hits"),
        currentTrackTitle: 'ignored stream title',
      );

      expect(session.kind, equals(PlaybackSessionKind.radio));
      expect(session.stationName, equals("America's Greatest 80s Hits"));
      expect(session.trackTitle, isNull);
    });

    test('uses currentTrack title, not a queued name, for music', () {
      final session = PlaybackSession.resolve(
        voiceChannelId: voiceChannelId,
        botChannelId: voiceChannelId,
        currentTrackTitle: 'Hey Jude (Remastered 2015)',
      );

      expect(session.kind, equals(PlaybackSessionKind.music));
      expect(session.trackTitle, equals('Hey Jude (Remastered 2015)'));
    });

    test('is idle when the bot is in a different voice channel', () {
      expect(
        PlaybackSession.resolve(
          voiceChannelId: voiceChannelId,
          botChannelId: otherChannelId,
          radio: _guildRadio('Station A'),
          currentTrackTitle: 'Hey Jude',
        ).kind,
        equals(PlaybackSessionKind.idle),
      );
    });

    test('is idle when radio is bound to a different VC', () {
      expect(
        PlaybackSession.resolve(
          voiceChannelId: voiceChannelId,
          botChannelId: voiceChannelId,
          radio: _guildRadio('Station A', voiceChannelId: otherChannelId),
        ).kind,
        equals(PlaybackSessionKind.idle),
      );
    });

    test('returns lavalinkError when Lavalink is unavailable', () {
      expect(
        PlaybackSession.resolve(
          voiceChannelId: voiceChannelId,
          botChannelId: voiceChannelId,
          lavalinkUnavailable: true,
        ).kind,
        equals(PlaybackSessionKind.lavalinkError),
      );
    });
  });
}

GuildRadio _guildRadio(
  String name, {
  Snowflake voiceChannelId = const Snowflake(2),
}) {
  return GuildRadio(
    const Snowflake(1),
    voiceChannelId: voiceChannelId,
    textChannelId: const Snowflake(3),
    station: Station(
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
    ),
  );
}
