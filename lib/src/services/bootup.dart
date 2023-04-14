import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:retry/retry.dart';

class BootUpService {
  BootUpService._(this._client, this.databaseService) {
    _client.eventsWs.onReady.listen(_initialize);
  }

  static void init(INyxxWebsocket client, DatabaseService databaseService) {
    _instance = BootUpService._(
      client,
      databaseService,
    );
  }

  static BootUpService get instance =>
      _instance ??
      (throw Exception(
        'DB service must be initialised with DB.init',
      ));

  static BootUpService? _instance;

  final DatabaseService databaseService;
  final INyxxWebsocket _client;

  /// Grabs the previously playing radio and sets it as the current one
  /// for the guild
  Future<void> _initialize(_) async {
    final cluster = await retry<ICluster?>(
      () async {
        final mCluster = MusicService.instance.cluster;
        if (mCluster.connectedNodes.isEmpty) {
          throw Exception('No nodes connected yet... retrying');
        } else {
          return mCluster;
        }
      },
      maxAttempts: 10,
      delayFactor: const Duration(seconds: 5),
    );

    if (cluster == null || cluster.connectedNodes.isEmpty) {
      return;
    }

    final allPlaying = await databaseService.getAllPlaying();

    if (allPlaying == null) {
      return;
    }

    for (final playing in allPlaying) {
      final guild = await _client.fetchGuild(playing.guildId);

      await connectToChannel(
        guild,
        playing.voiceChannelId,
        replace: true,
      );

      final node =
          MusicService.instance.cluster.getOrCreatePlayerNode(guild.id);
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
    }
  }
}
