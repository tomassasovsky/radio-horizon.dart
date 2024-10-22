import 'dart:async';

import 'package:injector/injector.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_horizon/radio_horizon.dart';

class BootUpService {
  BootUpService();

  DatabaseService get databaseService => Injector().get<DatabaseService>();
  NyxxGateway get _client => Injector().get<NyxxGateway>();

  /// Grabs the previously playing radio and sets it as the current one
  /// for the guild
  Future<void> init() async {
    final allPlaying = await databaseService.getAllPlaying();

    if (allPlaying == null) {
      return;
    }

    for (final playing in allPlaying) {
      try {
        final guild = await _client.guilds.fetch(playing.guildId);

        await connectToChannel(
          guild,
          playing.voiceChannelId,
          replace: true,
        );

        final voiceState = guild.voiceStates[playing.voiceChannelId]!;
        final voiceChannel =
            (await voiceState.channel!.fetch()) as VoiceChannel;

        final lavalinkPlayer = await voiceChannel.connectLavalink();

        await lavalinkPlayer.stopPlaying();
        await lavalinkPlayer
            .playEncoded(playing.station.urlResolved ?? playing.station.url);

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
