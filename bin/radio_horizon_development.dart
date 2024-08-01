// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:get_it/get_it.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:shazam_client/shazam_client.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  dotEnvFlavour = DotEnvFlavour.development;
  dotEnvFlavour.initialize();

  // Create nyxx client and nyxx_commands plugin
  final client = NyxxFactory.createNyxxWebsocket(token, intents);

  final commands = CommandsPlugin(
    prefix: mentionOr((_) => prefix),
    options: const CommandsOptions(
      logErrors: false,
    ),
  )
    ..addCommand(info)
    ..addCommand(skip)
    ..addCommand(stop)
    ..addCommand(join)
    ..addCommand(leave)
    ..addCommand(pause)
    ..addCommand(resume)
    ..addCommand(volume)
    ..addCommand(music)
    ..addCommand(radio)
    ..onCommandError.listen(commandErrorHandler);

  client
    ..registerPlugin(
      Logging(
        logLevel: Level.FINE,
        truncateLogsAt: 10000,
      ),
    )
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions())
    ..registerPlugin(commands);

  final databaseService = DatabaseService(client);
  await databaseService.initialize();

  final musicService = MusicService(client);
  final bootupService =
      BootUpService(client: client, databaseService: databaseService);
  final songRecognitionService =
      SongRecognitionService(ShazamClient.dockerized());

  getIt
    ..registerSingleton<MusicService>(musicService)
    ..registerSingleton<DatabaseService>(databaseService)
    ..registerSingleton<BootUpService>(bootupService)
    ..registerSingleton<SongRecognitionService>(songRecognitionService);

  client.onReady.listen((_) async {
    await musicService.initialize();
    await bootupService.initialize(musicService.cluster);
  });

  // Connect
  await client.connect();
}
