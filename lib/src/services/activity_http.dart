// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/src/services/activity_bind.dart';
import 'package:radio_horizon/src/services/playback.dart';
import 'package:radio_horizon/src/services/playback_session.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

class ActivityHttpService {
  ActivityHttpService({
    required ActivityBindService bind,
    required PlaybackService playback,
    required LavalinkClient lavalink,
    required RadioBrowserApi radioBrowser,
    required int port,
    String staticRoot = 'activity/dist',
    String clientId = '',
  })  : _bind = bind,
        _playback = playback,
        _lavalink = lavalink,
        _radioBrowser = radioBrowser,
        _port = port,
        _staticRoot = staticRoot,
        _clientId = clientId;

  final ActivityBindService _bind;
  final PlaybackService _playback;
  final LavalinkClient _lavalink;
  final RadioBrowserApi _radioBrowser;
  final int _port;
  final String _staticRoot;
  final String _clientId;
  final _logger = Logger('ActivityHttpService');
  HttpServer? _server;

  Handler get handler {
    final router = Router()
      ..get('/healthz', _healthz)
      ..post('/api/token', _token)
      ..get('/api/now-playing', _nowPlaying)
      ..get('/api/search/radio', _searchRadio)
      ..get('/api/search/music', _searchMusic)
      ..post('/api/play/radio', _playRadio)
      ..post('/api/play/music', _playMusic)
      ..post('/api/skip', _skip)
      ..post('/api/stop', _stop)
      ..post('/api/volume', _volume)
      ..post('/api/recognize', _recognize)
      ..post('/api/upvote', _upvote);

    final dist = Directory(_staticRoot);
    if (!dist.existsSync()) {
      return const Pipeline().addHandler(router.call);
    }
    return Cascade().add(router.call).add(_staticWithClientId()).handler;
  }

  Handler _staticWithClientId() {
    final inner = createStaticHandler(
      _staticRoot,
      defaultDocument: 'index.html',
    );
    return (request) async {
      final response = await inner(request);
      final path = request.requestedUri.path;
      final isIndex = path == '/' || path.endsWith('/index.html');
      if (!isIndex || _clientId.isEmpty) {
        return response;
      }
      final html = await response.readAsString();
      return response.change(
        body: html.replaceAll('__DISCORD_CLIENT_ID_PLACEHOLDER__', _clientId),
      );
    };
  }

  Future<void> start() async {
    if (!Directory(_staticRoot).existsSync()) {
      _logger.info(
        'Activity static root $_staticRoot is missing; serving API only',
      );
    }
    try {
      _server = await io.serve(handler, InternetAddress.anyIPv4, _port);
      _logger.info('Activity HTTP listening on port $_port');
    } on Object catch (error, stackTrace) {
      _logger.warning(
        'Failed to bind Activity HTTP on port $_port',
        error,
        stackTrace,
      );
    }
  }

  Future<void> close() async {
    await _server?.close(force: true);
    _server = null;
  }

  Response _healthz(Request request) {
    return Response.ok('ok');
  }

  Future<Response> _token(Request request) async {
    try {
      final body = await _jsonMap(request);
      final code = body['code']?.toString();
      if (code == null || code.isEmpty) {
        return _error(400, 'unauthorized');
      }
      final token = await _bind.exchangeToken(code);
      if (token == null) {
        return _error(401, 'unauthorized');
      }
      return _json(200, {'access_token': token});
    } on Object catch (error, stackTrace) {
      _logger.warning('POST /api/token failed', error, stackTrace);
      return _error(401, 'unauthorized');
    }
  }

  Future<Response> _nowPlaying(Request request) {
    return _withBind(request, (bound) async {
      final session =
          await _playback.nowPlaying(bound.guildId, bound.channelId);
      return _json(200, {
        'kind': switch (session.kind) {
          PlaybackSessionKind.idle => 'idle',
          PlaybackSessionKind.radio => 'radio',
          PlaybackSessionKind.music => 'music',
          PlaybackSessionKind.lavalinkError => 'lavalink_error',
        },
        'stationName': session.stationName,
        'trackTitle': session.trackTitle,
      });
    });
  }

  Future<Response> _searchRadio(Request request) {
    return _withBind(request, (_) async {
      final query = request.url.queryParameters['q'] ?? '';
      if (query.isEmpty) {
        return _json(200, {'stations': <Object>[]});
      }
      final response = await _radioBrowser.getStationsByName(
        name: query,
        parameters: const InputParameters(limit: 5),
      );
      return _json(200, {
        'stations': [
          for (final station in response.items.take(5))
            {
              'stationUuid': station.stationUUID,
              'name': station.name,
            },
        ],
      });
    });
  }

  Future<Response> _searchMusic(Request request) {
    return _withBind(request, (_) async {
      final query = request.url.queryParameters['q'] ?? '';
      final source = request.url.queryParameters['source'] ?? 'ytsearch';
      if (query.isEmpty) {
        return _json(200, {'tracks': <Object>[]});
      }
      final allowed = {'ytsearch', 'dzsearch'};
      if (!allowed.contains(source)) {
        return _error(400, 'forbidden');
      }
      final result = await _lavalink.loadTrack('$source:$query');
      final tracks = switch (result) {
        SearchLoadResult(:final data) => data,
        TrackLoadResult(:final data) => [data],
        _ => const <Track>[],
      };
      return _json(200, {
        'tracks': [
          for (final track in tracks.take(5))
            {
              'encoded': track.encoded,
              'title': track.info.title,
              'author': track.info.author,
            },
        ],
      });
    });
  }

  Future<Response> _playRadio(Request request) {
    return _withBind(request, (bound) async {
      final body = await _jsonMap(request);
      final uuid = body['stationUuid']?.toString();
      if (uuid == null || uuid.isEmpty) {
        return _error(400, 'forbidden');
      }
      final stations = await _radioBrowser.getStationsByUUID(uuids: [uuid]);
      if (stations.items.isEmpty) {
        return _error(404, 'forbidden');
      }
      final station = stations.items.first;
      final outcome = await _playback.playRadio(
        bound.guildId,
        bound.channelId,
        station: station,
        textChannelId: bound.channelId,
      );
      return _playbackResponse(outcome);
    });
  }

  Future<Response> _playMusic(Request request) {
    return _withBind(request, (bound) async {
      final body = await _jsonMap(request);
      final encoded = body['encodedTrack']?.toString();
      if (encoded == null || encoded.isEmpty) {
        return _error(400, 'forbidden');
      }
      final track = await _lavalink.decodeTrack(encoded);
      final outcome = await _playback.playEncodedTrack(
        bound.guildId,
        bound.channelId,
        track,
      );
      return _playbackResponse(outcome);
    });
  }

  Future<Response> _skip(Request request) {
    return _withBind(request, (bound) async {
      return _playbackResponse(
        await _playback.skip(bound.guildId, bound.channelId),
      );
    });
  }

  Future<Response> _stop(Request request) {
    return _withBind(request, (bound) async {
      return _playbackResponse(
        await _playback.stop(bound.guildId, bound.channelId),
      );
    });
  }

  Future<Response> _volume(Request request) {
    return _withBind(request, (bound) async {
      final body = await _jsonMap(request);
      final volume = body['volume'];
      if (volume is! num) {
        return _error(400, 'forbidden');
      }
      return _playbackResponse(
        await _playback.setVolume(
          bound.guildId,
          bound.channelId,
          volume.round(),
        ),
      );
    });
  }

  Future<Response> _recognize(Request request) {
    return _withBind(request, (bound) async {
      final outcome = await _playback.recognize(bound.guildId, bound.channelId);
      if (!outcome.isSuccess) {
        return _playbackResponse(outcome);
      }
      return _json(200, {
        'title': outcome.song?.title,
        'subtitle': outcome.song?.subtitle,
        'stationName': outcome.radio?.station.name,
      });
    });
  }

  Future<Response> _upvote(Request request) {
    return _withBind(request, (bound) async {
      return _playbackResponse(
        await _playback.upvote(bound.guildId, bound.channelId),
      );
    });
  }

  Future<Response> _withBind(
    Request request,
    Future<Response> Function(BoundActivity bound) run,
  ) async {
    final authorization = request.headers['authorization'] ?? '';
    final bearer =
        authorization.startsWith('Bearer ') ? authorization.substring(7) : '';
    final instanceId = request.headers['x-discord-instance-id'] ?? '';
    try {
      final bound = await _bind.bind(
        bearerToken: bearer,
        instanceId: instanceId,
      );
      return await run(bound);
    } on ActivityBindException catch (error) {
      return _error(error.statusCode, error.code);
    } on Object catch (error, stackTrace) {
      _logger.warning('Activity API request failed', error, stackTrace);
      return _error(500, 'forbidden');
    }
  }

  Response _playbackResponse(PlaybackResult outcome) {
    if (outcome.isSuccess) {
      return _json(200, {'ok': true});
    }
    return switch (outcome.error) {
      PlaybackError.nothingToSkip => _error(409, 'nothing_to_skip'),
      PlaybackError.radioOnly => _error(409, 'radio_only'),
      PlaybackError.lavalinkUnavailable => _error(503, 'lavalink_unavailable'),
      PlaybackError.wrongVoiceChannel => _error(403, 'not_in_voice'),
      PlaybackError.notPlaying => _error(409, 'nothing_to_skip'),
      null => _json(200, {'ok': true}),
    };
  }

  Future<Map<String, dynamic>> _jsonMap(Request request) async {
    final raw = await request.readAsString();
    if (raw.isEmpty) {
      return {};
    }
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map) {
      return decoded.cast<String, dynamic>();
    }
    return {};
  }

  Response _json(int status, Map<String, Object?> body) {
    return Response(
      status,
      body: jsonEncode(body),
      headers: const {'Content-Type': 'application/json'},
    );
  }

  Response _error(int status, String code) {
    return _json(status, {'error': code});
  }
}
