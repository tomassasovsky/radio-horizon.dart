// Copyright (c) 2024, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:http/http.dart' as http;
import 'package:injector/injector.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:shazam_client/shazam_client.dart';

Future<void> main() async {
  dotEnvFlavour = DotEnvFlavour.development;
  dotEnvFlavour.initialize();

  final commands = CommandsPlugin(
    prefix: null,
    guild: devGuildId,
    options: CommandsOptions(logErrors: dev),
  );

  final lavalinkClient = await LavalinkClient.connect(
    Uri(
      host: lavalinkAddress,
      port: lavalinkPort,
      scheme: lavalinkUseSSL ? 'https' : 'http',
    ),
    password: lavalinkPassword,
    userId: clientId.toString(),
  );

  final lavalinkPlugin = LavalinkPlugin.usingClient(lavalinkClient);

  commands
    ..addCommand(info)
    ..addCommand(skip)
    ..addCommand(stop)
    ..addCommand(join)
    ..addCommand(leave)
    ..addCommand(pause)
    ..addCommand(resume)
    ..addCommand(volume)
    ..addCommand(music)
    ..addCommand(radio);

  commands.onCommandError.listen(commandErrorHandler);

  final client = await Nyxx.connectGateway(
    token,
    intents,
    options: GatewayClientOptions(
      plugins: [
        Logging(),
        CliIntegration(),
        IgnoreExceptions(),
        commands,
        lavalinkPlugin,
      ],
    ),
  );

  Injector.appInstance
    ..registerSingleton(() => client)
    ..registerSingleton(DatabaseService.new)
    ..registerSingleton(BootUpService.new)
    ..registerSingleton(ShazamClient.dockerized)
    ..registerSingleton(SongRecognitionService.new)
    ..registerSingleton(BotStartDuration.new)
    ..registerSingleton(() => lavalinkClient)
    ..registerSingleton(() => lavalinkPlugin)
    ..registerSingleton(
      () => createPlaybackService(
        database: Injector.appInstance.get<DatabaseService>(),
        lavalink: lavalinkClient,
        recognition: Injector.appInstance.get<SongRecognitionService>(),
        connect: (guildId, channelId) async {
          final guild = await client.guilds.get(guildId);
          return await connectToChannel(guild, channelId);
        },
        botChannelId: (guildId) => client
            .guilds.cache[guildId]?.voiceStates[client.user.id]?.channelId,
      ),
    )
    ..registerSingleton(
      () => ActivityBindService(
        httpClient: http.Client(),
        clientId: clientId.toString(),
        clientSecret: clientSecret.isEmpty ? null : clientSecret,
        botToken: token,
        userVoiceChannel: (guildId, userId) =>
            client.guilds.cache[guildId]?.voiceStates[userId]?.channelId,
        isGuildVoice: (guildId, channelId) {
          final channel = client.channels.cache[channelId];
          return channel is GuildVoiceChannel;
        },
      ),
    )
    ..registerSingleton(
      () => ActivityHttpService(
        bind: Injector.appInstance.get<ActivityBindService>(),
        playback: Injector.appInstance.get<PlaybackService>(),
        lavalink: lavalinkClient,
        radioBrowser:
            const RadioBrowserApi.fromHost('de1.api.radio-browser.info'),
        port: activityHttpPort,
        staticRoot: activityDistDir,
        clientId: clientId.toString(),
      ),
    );

  await Injector.appInstance.get<BotStartDuration>().init();
  await Injector.appInstance.get<DatabaseService>().init();
  await Injector.appInstance.get<BootUpService>().init();
  await Injector.appInstance.get<ActivityHttpService>().start();
}
