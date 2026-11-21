import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:nyxx/nyxx.dart';
import 'package:radio_horizon/src/services/activity_bind.dart';
import 'package:test/test.dart';

class _MockClient extends Mock implements http.Client {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('https://discord.com/api/v10'));
    registerFallbackValue(<String, String>{});
  });

  const guildId = Snowflake(1);
  const channelId = Snowflake(2);
  const userId = Snowflake(10);

  late _MockClient client;
  late Map<String, int> gets;
  late ActivityBindService bind;

  setUp(() {
    client = _MockClient();
    gets = {};
    bind = ActivityBindService(
      httpClient: client,
      clientId: 'app',
      clientSecret: 'secret',
      botToken: 'bot',
      userVoiceChannel: (guild, user) =>
          guild == guildId && user == userId ? channelId : null,
      isGuildVoice: (guild, channel) =>
          guild == guildId && channel == channelId,
      discordApiBase: Uri.parse('https://discord.com/api/v10'),
    );

    when(
      () => client.get(any(), headers: any(named: 'headers')),
    ).thenAnswer((invocation) async {
      final uri = invocation.positionalArguments.first as Uri;
      gets[uri.path] = (gets[uri.path] ?? 0) + 1;
      if (uri.path.endsWith('/users/@me')) {
        return http.Response(jsonEncode({'id': userId.toString()}), 200);
      }
      if (uri.path.contains('activity-instances')) {
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
      }
      return http.Response('', 404);
    });

    when(
      () => client.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode({'access_token': 'tok'}), 200),
    );
  });

  group(ActivityBindService, () {
    test('exchanges an OAuth code for an access token', () async {
      expect(await bind.exchangeToken('code'), equals('tok'));
    });

    test('returns null when token exchange fails', () async {
      when(
        () => client.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => http.Response('nope', 500));

      expect(await bind.exchangeToken('code'), isNull);
    });

    test('invalid Bearer returns unauthorized', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('{}', 401));

      expect(
        () => bind.bind(bearerToken: 'bad', instanceId: 'inst'),
        throwsA(
          isA<ActivityBindException>().having(
            (error) => error.code,
            'code',
            'unauthorized',
          ),
        ),
      );
    });

    test('user not in the instance returns not_in_voice', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
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
            'users': ['99'],
          }),
          200,
        );
      });

      expect(
        () => bind.bind(bearerToken: 'tok', instanceId: 'inst'),
        throwsA(
          isA<ActivityBindException>().having(
            (error) => error.code,
            'code',
            'not_in_voice',
          ),
        ),
      );
    });

    test('DM and stage locations return not_in_voice', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((invocation) async {
        final uri = invocation.positionalArguments.first as Uri;
        if (uri.path.endsWith('/users/@me')) {
          return http.Response(jsonEncode({'id': userId.toString()}), 200);
        }
        return http.Response(
          jsonEncode({
            'location': {
              'kind': 'dm',
              'channel_id': channelId.toString(),
            },
            'users': [userId.toString()],
          }),
          200,
        );
      });

      await expectLater(
        bind.bind(bearerToken: 'tok', instanceId: 'inst'),
        throwsA(
          isA<ActivityBindException>().having(
            (error) => error.code,
            'code',
            'not_in_voice',
          ),
        ),
      );

      final stageBind = ActivityBindService(
        httpClient: client,
        clientId: 'app',
        clientSecret: 'secret',
        botToken: 'bot',
        userVoiceChannel: (guild, user) =>
            guild == guildId && user == userId ? channelId : null,
        isGuildVoice: (_, __) => false,
        discordApiBase: Uri.parse('https://discord.com/api/v10'),
      );
      when(
        () => client.get(any(), headers: any(named: 'headers')),
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

      await expectLater(
        stageBind.bind(bearerToken: 'tok', instanceId: 'inst'),
        throwsA(
          isA<ActivityBindException>().having(
            (error) => error.code,
            'code',
            'not_in_voice',
          ),
        ),
      );
    });

    test('caches bind so now-playing does not hit Discord every poll',
        () async {
      await bind.bind(bearerToken: 'tok', instanceId: 'inst');
      await bind.bind(bearerToken: 'tok', instanceId: 'inst');

      expect(
        gets.values.fold<int>(0, (sum, count) => sum + count),
        equals(2),
      );
    });
  });
}
