// Copyright (c) 2024, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:injector/injector.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
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

  // Remove Discord's auto-added Primary Entry Point command before connecting
  // so nyxx_commands' slash-command sync is not rejected with error 50240.
  await removeEntryPointCommand(token);

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
    ..registerSingleton(() => lavalinkPlugin);

  await Injector.appInstance.get<BotStartDuration>().init();
  await Injector.appInstance.get<DatabaseService>().init();
  await Injector.appInstance.get<BootUpService>().init();
}
