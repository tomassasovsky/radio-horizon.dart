import 'dart:async';

import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:retry/retry.dart';

class BootUpService {
  BootUpService({
    required INyxxWebsocket client,
    required this.databaseService,
  }) : _client = client;

  final DatabaseService databaseService;
  final INyxxWebsocket _client;

  /// Grabs the previously playing radio and sets it as the current one
  /// for the guild
  Future<void> initialize(ICluster cluster) async {
    final mCluster = await retry<ICluster?>(
      () async {
        if (cluster.connectedNodes.isEmpty) {
          throw Exception('No nodes connected yet... retrying');
        } else {
          return cluster;
        }
      },
      maxAttempts: 10,
      delayFactor: const Duration(seconds: 5),
    );

    if (mCluster == null || mCluster.connectedNodes.isEmpty) {
      return;
    }

    final allPlaying = await databaseService.getAllPlaying();

    if (allPlaying == null) {
      return;
    }

    for (final playing in allPlaying) {
      try {
        final guild = await _client.fetchGuild(playing.guildId);

        await connectToChannel(
          guild,
          playing.voiceChannelId,
          replace: true,
        );

        final node = mCluster.getOrCreatePlayerNode(guild.id);
        final tracks = await node
            .searchTracks(playing.station.urlResolved ?? playing.station.url);
        node
          ..players[guild.id]!.queue.clear()
          ..play(
            guild.id,
            tracks.tracks.first,
            replace: true,
            channelId: playing.voiceChannelId,
          ).startPlaying();

        await databaseService.setPlaying(
          GuildRadio(
            guild.id,
            voiceChannelId: playing.voiceChannelId,
            station: playing.station,
            textChannelId: playing.textChannelId,
          ),
        );
      } catch (e) {
        Logger.root.info(
          'Failed to initialize radio for guild: ${playing.guildId}',
        );
      }
    }
  }
}
