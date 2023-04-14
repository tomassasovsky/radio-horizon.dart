// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_horizon/radio_horizon.dart';

final _enMusicService = AppLocale.en.translations.services.music;

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
            clientName: 'RadioHorizon',
            shards: shards,
            // Bump up connection attempts to avoid timeouts in Docker
            maxConnectAttempts: 10,
          ),
        );

        for (var i = 0; i < 10; i++) {
          if (cluster.connectedNodes.isNotEmpty) {
            break;
          }

          await Future<void>.delayed(const Duration(seconds: 5));
        }

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
        _client.eventsWs.onVoiceStateUpdate.listen(_voiceStateUpdate);
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
        ..title = _enMusicService.trackStarted.title
        ..description = _enMusicService.trackStarted.description(
          track: track!.track.info!.title,
          uri: track.track.info!.uri,
          requester: track.requester!,
        )
        ..thumbnailUrl =
            'https://img.youtube.com/vi/${track.track.info?.identifier}/hqdefault.jpg';

      await _client.httpEndpoints.sendMessage(
        track.channelId!,
        MessageBuilder.embed(embed),
      );
    }
  }

  Future<void> _trackEnded(ITrackEndEvent event) async {
    await Future<void>.delayed(const Duration(seconds: 30));

    if (!event.node.players.containsKey(event.guildId)) {
      return;
    }

    // disconnect the bot if the queue is empty
    final player = event.node.players[event.guildId];
    if (player != null && player.queue.isEmpty && player.nowPlaying == null) {
      final guildId = event.guildId;
      final hasGuild = event.client.guilds.containsKey(guildId);

      if (!hasGuild) {
        return;
      }

      final guild = await event.client.httpEndpoints.fetchGuild(guildId);

      event.node.destroy(guild.id);
      guild.shard.changeVoiceState(guild.id, null);

      // delete the current radio station from the list, if it exists
      await SongRecognitionService.instance.deleteRadioFromList(guild.id);

      Logger('MusicService').info(
        'Disconnected from voice channel in guild ${guild.id} '
        '(${guild.name})',
      );
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
        ..title = _enMusicService.trackStuck.title
        ..description = _enMusicService.trackStuck.description(
          track: track.track.info!.title,
          uri: track.track.info!.uri,
          requester: track.requester!,
        )
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
        ..title = _enMusicService.trackException.title
        ..description = _enMusicService.trackException.description(
          track: track.track.info!.title,
          uri: track.track.info!.uri,
          requester: track.requester!,
        )
        ..thumbnailUrl =
            'https://img.youtube.com/vi/${track.track.info?.identifier}/hqdefault.jpg';

      await _client.httpEndpoints
          .sendMessage(track.channelId!, MessageBuilder.embed(embed));
    }
  }

  static void init(INyxxWebsocket client) {
    _instance = MusicService._(client);
  }

  Future<void> _voiceStateUpdate(IVoiceStateUpdateEvent event) async {
    if (event.state.user.id == _client.appId) return;
    if (event.oldState == null) return;

    final eventChannelId =
        event.state.channel?.id ?? event.oldState?.channel?.id;
    final cachedGuild = event.state.guild;
    if (cachedGuild == null || eventChannelId == null) {
      Logger('VoiceStateUpdate').warning(
        'VoiceStateUpdate event with null guild or channel: '
        '$cachedGuild, $eventChannelId',
      );
      return;
    }

    var guild = await cachedGuild.getOrDownload();
    final botMember = await guild.selfMember.getOrDownload();

    if (botMember.voiceState == null) return;
    final currentChannelId = botMember.voiceState?.channel?.id;

    if (currentChannelId == null) {
      Logger('VoiceStateUpdate').warning(
        'VoiceStateUpdate event with null bot channel: '
        '$currentChannelId',
      );
      return;
    }

    if (eventChannelId != currentChannelId) {
      // the event is not for the bot's current channel
      Logger('VoiceStateUpdate').info(
        'VoiceStateUpdate event for channel $eventChannelId '
        'does not match bot channel $currentChannelId',
      );
      return;
    }

    /// Returns a list of members connected to the same voice channel as the
    /// [event] member. Excludes the bot, if present.
    bool hasConnectedMembers(IGuild iGuild) {
      final voiceStatesInChannel = iGuild.voiceStates.entries.where((element) {
        return element.value.channel?.id == currentChannelId &&
            element.key != botMember.id;
      });
      return voiceStatesInChannel.isNotEmpty;
    }

    if (!hasConnectedMembers(guild)) {
      // Wait 30 seconds before destroying the player
      await Future<void>.delayed(const Duration(seconds: 30));

      // get the guild again in case it was updated
      guild = await cachedGuild.download();

      if (!hasConnectedMembers(guild)) {
        try {
          MusicService.instance.cluster
              .getOrCreatePlayerNode(guild.id)
              .destroy(guild.id);

          guild.shard.changeVoiceState(guild.id, null);

          await DatabaseService.instance.setNotPlaying(guild.id);

          final channel = await guild.publicUpdatesChannel?.getOrDownload();
          if (channel == null) {
            Logger('MusicService').warning(
              'Destroyed player for guild ${guild.id} but the guild '
              'public updates channel is null',
            );
            return;
          }

          final commandTranslations = getCommandTranslationsForGuild(guild);

          final embed = EmbedBuilder()
            ..color = getRandomColor()
            ..title = commandTranslations.leave.left
            ..description = commandTranslations.leave.leftDueToInactivity;

          await channel.sendMessage(MessageBuilder.embed(embed));
        } catch (e) {
          if (e.toString().contains('LateInitializationError')) return;
          Logger('MusicService').warning(
            'Failed to destroy player for guild ${guild.id}: $e',
          );
        }
      }
    }
  }
}
