// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nyxx/nyxx.dart';

class ActivityBindException implements Exception {
  const ActivityBindException(this.statusCode, this.code);

  final int statusCode;
  final String code;
}

class BoundActivity {
  const BoundActivity({
    required this.guildId,
    required this.channelId,
    required this.userId,
  });

  final Snowflake guildId;
  final Snowflake channelId;
  final Snowflake userId;
}

class _CacheEntry {
  _CacheEntry(this.bound, this.expiresAt);

  final BoundActivity bound;
  final DateTime expiresAt;

  bool get isFresh => DateTime.now().isBefore(expiresAt);
}

class ActivityBindService {
  ActivityBindService({
    required http.Client httpClient,
    required String clientId,
    required String botToken,
    required Snowflake? Function(Snowflake guildId, Snowflake userId)
        userVoiceChannel,
    required bool Function(Snowflake guildId, Snowflake channelId) isGuildVoice,
    String? clientSecret,
    Duration cacheTtl = const Duration(seconds: 45),
    Uri? discordApiBase,
  })  : _http = httpClient,
        _clientId = clientId,
        _clientSecret = clientSecret,
        _botToken = botToken,
        _userVoiceChannel = userVoiceChannel,
        _isGuildVoice = isGuildVoice,
        _cacheTtl = cacheTtl,
        _apiBase = discordApiBase ?? Uri.parse('https://discord.com/api/v10');

  final http.Client _http;
  final String _clientId;
  final String? _clientSecret;
  final String _botToken;
  final Snowflake? Function(Snowflake guildId, Snowflake userId)
      _userVoiceChannel;
  final bool Function(Snowflake guildId, Snowflake channelId) _isGuildVoice;
  final Duration _cacheTtl;
  final Uri _apiBase;
  final Map<String, _CacheEntry> _cache = {};
  final _logger = Logger('ActivityBindService');

  Future<String?> exchangeToken(String code) async {
    final secret = _clientSecret;
    if (secret == null || secret.isEmpty) {
      _logger.warning('CLIENT_SECRET is not set; token exchange skipped');
      return null;
    }

    try {
      final response = await _http.post(
        _apiBase.replace(path: '${_apiBase.path}/oauth2/token'),
        headers: const {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': 'https://127.0.0.1',
          'client_id': _clientId,
          'client_secret': secret,
        },
      );
      if (response.statusCode < 200 || response.statusCode >= 300) {
        _logger.warning(
          'Token exchange failed with HTTP ${response.statusCode}',
        );
        return null;
      }
      final json = jsonDecode(response.body);
      if (json is! Map<String, dynamic>) {
        return null;
      }
      final token = json['access_token'];
      return token is String && token.isNotEmpty ? token : null;
    } on Object catch (error, stackTrace) {
      _logger.warning('Token exchange failed', error, stackTrace);
      return null;
    }
  }

  Future<BoundActivity> bind({
    required String bearerToken,
    required String instanceId,
  }) async {
    if (bearerToken.isEmpty || instanceId.isEmpty) {
      throw const ActivityBindException(401, 'unauthorized');
    }

    final cacheKey = '$instanceId:$bearerToken';
    final cached = _cache[cacheKey];
    if (cached != null && cached.isFresh) {
      return cached.bound;
    }

    try {
      final userId = await _fetchUserId(bearerToken);
      final bound = await _fetchAndValidate(
        instanceId: instanceId,
        userId: userId,
      );
      _cache[cacheKey] = _CacheEntry(bound, DateTime.now().add(_cacheTtl));
      return bound;
    } on ActivityBindException {
      _invalidateInstance(instanceId);
      rethrow;
    }
  }

  void _invalidateInstance(String instanceId) {
    _cache.removeWhere((key, _) => key.startsWith('$instanceId:'));
  }

  Future<Snowflake> _fetchUserId(String bearerToken) async {
    final response = await _http.get(
      _apiBase.replace(path: '${_apiBase.path}/users/@me'),
      headers: {'Authorization': 'Bearer $bearerToken'},
    );
    if (response.statusCode == 401 || response.statusCode == 403) {
      throw const ActivityBindException(401, 'unauthorized');
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw const ActivityBindException(401, 'unauthorized');
    }
    final json = jsonDecode(response.body);
    if (json is! Map<String, dynamic> || json['id'] is! String) {
      throw const ActivityBindException(401, 'unauthorized');
    }
    return Snowflake.parse(json['id']! as String);
  }

  Future<BoundActivity> _fetchAndValidate({
    required String instanceId,
    required Snowflake userId,
  }) async {
    final response = await _http.get(
      _apiBase.replace(
        path: '${_apiBase.path}/applications/$_clientId/activity-instances/'
            '$instanceId',
      ),
      headers: {'Authorization': 'Bot $_botToken'},
    );
    if (response.statusCode == 401) {
      throw const ActivityBindException(401, 'unauthorized');
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw const ActivityBindException(403, 'not_in_voice');
    }

    final json = jsonDecode(response.body);
    if (json is! Map<String, dynamic>) {
      throw const ActivityBindException(403, 'not_in_voice');
    }

    final users = json['users'];
    final userIds = <String>{};
    if (users is List) {
      for (final user in users) {
        if (user is String) {
          userIds.add(user);
        } else if (user is Map && user['id'] is String) {
          userIds.add(user['id'] as String);
        }
      }
    }
    if (!userIds.contains(userId.toString())) {
      throw const ActivityBindException(403, 'not_in_voice');
    }

    final location = json['location'];
    if (location is! Map) {
      throw const ActivityBindException(403, 'not_in_voice');
    }
    final kind = location['kind']?.toString();
    if (kind != 'gc') {
      throw const ActivityBindException(403, 'not_in_voice');
    }
    final guildRaw = location['guild_id']?.toString();
    final channelRaw = location['channel_id']?.toString();
    if (guildRaw == null || channelRaw == null) {
      throw const ActivityBindException(403, 'not_in_voice');
    }

    final guildId = Snowflake.parse(guildRaw);
    final channelId = Snowflake.parse(channelRaw);
    if (!_isGuildVoice(guildId, channelId)) {
      throw const ActivityBindException(403, 'not_in_voice');
    }

    final voiceChannel = _userVoiceChannel(guildId, userId);
    if (voiceChannel != channelId) {
      throw const ActivityBindException(403, 'not_in_voice');
    }

    return BoundActivity(
      guildId: guildId,
      channelId: channelId,
      userId: userId,
    );
  }
}
