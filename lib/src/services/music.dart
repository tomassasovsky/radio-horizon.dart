// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_garden/radio_garden.dart';
import 'package:radio_garden/src/util.dart';

class MusicService {
  MusicService._(this._client) {
    _client.onReady.listen((_) async {
      if (_cluster == null) {
        _cluster = ICluster.createCluster(_client, _client.appId);

        final host = serverAddress;
        final port = serverPort;
        final password = serverPassword;
        final ssl = useSSL;
        final shards = _client.shardManager.totalNumShards;

        await usage?.sendEvent('MusicService:constructor', 'start');

        Logger('MusicService').info(
          'Connecting to Lavalink server at $host:$port (SSL: $ssl, '
          'Shards: $shards)',
        );

        await cluster.addNode(
          NodeOptions(
            host: host,
            port: port,
            password: password,
            ssl: ssl,
            clientName: 'RadioGarden',
            shards: shards,
            // Bump up connection attempts to avoid timeouts in Docker
            maxConnectAttempts: 10,
          ),
        );

        if (cluster.connectedNodes.isEmpty) {
          Logger('MusicService').severe(
            'Failed to connect to Lavalink server at $host:$port (SSL: $ssl, '
            'Shards: $shards)',
          );

          await usage?.sendEvent(
            'MusicService:constructor',
            'lavalink-connection-failure',
          );

          return;
        }

        await usage?.sendEvent(
          'MusicService:constructor',
          'lavalink-connection-successful',
        );

        cluster.eventDispatcher.onTrackStart.listen(_trackStarted);
        cluster.eventDispatcher.onTrackStuck.listen(_trackStuck);
        cluster.eventDispatcher.onTrackEnd.listen(_trackEnded);
        cluster.eventDispatcher.onTrackException.listen(_trackException);
      }
    });
  }
  static MusicService get instance =>
      _instance ??
      (throw Exception(
        'Music service must be initialised with MusicService.init',
      ));

  static MusicService? _instance;

  final INyxxWebsocket _client;

  ICluster get cluster =>
      _cluster ??
      (throw Exception('Cluster must be accessed after `on_ready` event'));

  /// The cluster used to interact with lavalink
  ICluster? _cluster;

  Future<void> _trackStarted(ITrackStartEvent event) async {
    final player = event.node.players[event.guildId];

    if (player == null) {
      Logger('MusicService').warning(
        'Received track start event for guild ${event.guildId} but no player '
        'was found',
      );

      await usage?.sendEvent(
        'MusicService:_trackStarted',
        'no-player-found',
        label: event.guildId.toString(),
      );

      return;
    }

    Logger('MusicService').info(
      'Track started: ${player.nowPlaying?.track.info?.title} '
      '(${player.nowPlaying?.track.info?.uri})',
    );

    if (player.nowPlaying != null) {
      final track = player.nowPlaying;
      await usage?.sendEvent(
        'MusicService:_trackStarted',
        'track-started',
        label: track?.track.info?.title,
        parameters: queuedTrackToAnalyticsParameters(track!),
      );

      final embed = EmbedBuilder()
        ..color = getRandomColor()
        ..title = 'Track started'
        ..description =
            'Track [${track?.track.info?.title}](${track?.track.info?.uri}) '
                'started playing.\n\nRequested by <@${track?.requester!}>'
        ..thumbnailUrl =
            'https://img.youtube.com/vi/${track?.track.info?.identifier}/hqdefault.jpg';

      await _client.httpEndpoints.sendMessage(
        track!.channelId!,
        MessageBuilder.embed(embed),
      );
    }
  }

  Future<void> _trackEnded(ITrackEndEvent event) async {
    await Future<void>.delayed(const Duration(minutes: 5));

    // disconnect the bot if the queue is empty
    final player = event.node.players[event.guildId];
    if (player != null && player.queue.isEmpty) {
      event.node.destroy(event.guildId);
    }
  }

  Future<void> _trackStuck(ITrackStuckEvent event) async {
    final player = event.node.players[event.guildId];

    if (player == null) {
      Logger('MusicService').warning(
        'Received track stuck event for guild ${event.guildId} but no player '
        'was found',
      );

      await usage?.sendEvent(
        'MusicService:_trackStuck',
        'no-player-found',
        label: event.guildId.toString(),
      );

      return;
    }

    Logger('MusicService').warning(
      'Track stuck: ${player.nowPlaying?.track.info?.title} '
      '(${player.nowPlaying?.track.info?.uri})',
    );

    await usage?.sendEvent(
      'MusicService:_trackStuck',
      'reason-unknown',
      label: event.guildId.toString(),
    );

    if (player.queue.isNotEmpty) {
      final track = player.queue[0];

      await usage?.sendEvent(
        'MusicService:_trackStuck',
        'track-stuck',
        label: track.track.info?.title,
        parameters: queuedTrackToAnalyticsParameters(track),
      );

      final embed = EmbedBuilder()
        ..color = getRandomColor()
        ..title = 'Track stuck'
        ..description =
            'Track [${track.track.info?.title}](${track.track.info?.uri}) '
                'stuck playing.\n\nRequested by <@${track.requester!}>'
        ..thumbnailUrl =
            'https://img.youtube.com/vi/${track.track.info?.identifier}/hqdefault.jpg';

      await _client.httpEndpoints
          .sendMessage(track.channelId!, MessageBuilder.embed(embed));
    }
  }

  Future<void> _trackException(ITrackExceptionEvent event) async {
    final player = event.node.players[event.guildId];

    if (player != null && player.queue.isNotEmpty) {
      final track = player.queue[0];

      await usage?.sendEvent(
        'MusicService:_trackException',
        'track-exception',
        label: track.track.info?.title,
        parameters: queuedTrackToAnalyticsParameters(track),
      );

      final embed = EmbedBuilder()
        ..color = getRandomColor()
        ..title = 'Track exception'
        ..description =
            'Track [${track.track.info?.title}](${track.track.info?.uri}) '
                'exception playing.\n\nRequested by <@${track.requester!}>'
        ..thumbnailUrl =
            'https://img.youtube.com/vi/${track.track.info?.identifier}/hqdefault.jpg';

      await _client.httpEndpoints
          .sendMessage(track.channelId!, MessageBuilder.embed(embed));
    }
  }

  static void init(INyxxWebsocket client) {
    _instance = MusicService._(client);
  }
}
