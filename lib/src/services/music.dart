// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_horizon/radio_horizon.dart';

final _enMusicService = AppLocale.en.translations.services.music;
final getIt = GetIt.instance;

class MusicService {
  MusicService(this._client);

  final logger = Logger('MusicService');
  final INyxxWebsocket _client;

  ICluster get cluster =>
      _cluster ??
      (throw Exception('Cluster must be accessed after `on_ready` event'));

  /// Initializes the music service
  Future<void> initialize() async {
    if (_cluster == null) {
      _cluster = ICluster.createCluster(_client, _client.appId);

      final host = serverAddress;
      final port = serverPort;
      final password = serverPassword;
      final ssl = useSSL;
      final shards = _client.shardManager.totalNumShards;

      logger.info(
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
        logger.severe(
          'Failed to connect to Lavalink server at $host:$port (SSL: $ssl, '
          'Shards: $shards)',
        );

        return;
      }

      logger.info(
        'MusicService:constructor: lavalink-connection-successful',
      );

      cluster.eventDispatcher.onTrackStart.listen(_trackStarted);
      cluster.eventDispatcher.onTrackStuck.listen(_trackStuck);
      cluster.eventDispatcher.onTrackEnd.listen(_trackEnded);
      cluster.eventDispatcher.onTrackException.listen(_trackException);
    }
  }

  /// The cluster used to interact with lavalink
  ICluster? _cluster;

  Future<void> _trackStarted(ITrackStartEvent event) async {
    final player = event.node.players[event.guildId];

    if (player == null) {
      logger.severe(
        'Received track start event for guild ${event.guildId} but '
        'no player was found',
      );

      return;
    }

    logger.info(
      'Track started: ${player.nowPlaying?.track.info?.title} '
      '(${player.nowPlaying?.track.info?.uri})',
    );

    if (player.nowPlaying != null) {
      final track = player.nowPlaying;

      final log = StringBuffer()
        ..writeln('Track started: ${track?.track.info?.title}')
        ..writeln('Track URL: ${track?.track.info?.uri}')
        ..writeln('Parameters: ${queuedTrackToAnalyticsParameters(track!)}');

      logger.info(log.toString());

      final embed = EmbedBuilder()
        ..color = getRandomColor()
        ..title = _enMusicService.trackStarted.title
        ..description = _enMusicService.trackStarted.description(
          track: track.track.info!.title,
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

    final databaseService = getIt.get<DatabaseService>();
    try {
      await databaseService.currentRadio(event.guildId);
      // if the current radio is not null, it means the bot is playing a radio
      return;
    } catch (e) {
      logger.severe(
        'MusicService:_trackEnded: failed to get current radio: $e',
      );
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
      await getIt.get<DatabaseService>().deleteRadioFromList(guild.id);

      logger.info(
        'Disconnected from voice channel in guild ${guild.id} '
        '(${guild.name})',
      );
    }
  }

  Future<void> _trackStuck(ITrackStuckEvent event) async {
    final player = event.node.players[event.guildId];

    if (player == null) {
      logger.severe(
        'Received track stuck event for guild ${event.guildId} but no player '
        'was found',
      );

      return;
    }

    if (player.queue.isNotEmpty) {
      final track = player.queue[0];

      logger.severe(
        'MusicService:_trackStuck: ${queuedTrackToAnalyticsParameters(track)}',
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
    } else {
      logger.severe(
        'Track stuck: ${player.nowPlaying?.track.info?.title} '
        '(${player.nowPlaying?.track.info?.uri})',
      );
    }
  }

  Future<void> _trackException(ITrackExceptionEvent event) async {
    final player = event.node.players[event.guildId];

    if (player != null && player.queue.isNotEmpty) {
      final track = player.queue[0];

      logger.severe(
        'MusicService:_trackException - '
        '${queuedTrackToAnalyticsParameters(track)}',
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

  Future<void> voiceStateUpdate(IVoiceStateUpdateEvent event) async {
    if (event.state.user.id == _client.appId) return;
    if (event.oldState == null) return;

    final eventChannelId =
        event.state.channel?.id ?? event.oldState?.channel?.id;
    final cachedGuild = event.state.guild;
    if (cachedGuild == null || eventChannelId == null) {
      logger.severe(
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
      logger.severe(
        'VoiceStateUpdate event with null bot channel: '
        '$currentChannelId',
      );
      return;
    }

    if (eventChannelId != currentChannelId) {
      // the event is not for the bot's current channel
      logger.severe(
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
          cluster.getOrCreatePlayerNode(guild.id).destroy(guild.id);
          guild.shard.changeVoiceState(guild.id, null);

          await getIt.get<DatabaseService>().setNotPlaying(guild.id);

          final channel = await guild.publicUpdatesChannel?.getOrDownload();
          if (channel == null) {
            logger.warning(
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
          logger.severe(
            'Failed to destroy player for guild ${guild.id}: $e',
          );
        }
      }
    }
  }
}
