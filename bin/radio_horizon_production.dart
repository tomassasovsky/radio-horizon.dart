// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:usage/usage.dart';

Future<void> main() async {
  dotEnvFlavour = DotEnvFlavour.production;
  dotEnvFlavour.initialize();

  Logger.root.level = Level.FINE;

  usage?.analyticsOpt = AnalyticsOpt.optIn;
  usage?.enabled = true;
  await usage?.sendEvent('main:setup', 'start');

  // Create nyxx client and nyxx_commands plugin
  final client = NyxxFactory.createNyxxWebsocket(token, intents);

  final commands = CommandsPlugin(
    prefix: mentionOr((_) => prefix),
    options: const CommandsOptions(
      logErrors: false,
    ),
  )
    ..addCommand(info)
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

  // Initialise our services
  PrometheusService.init(client, commands);
  MusicService.init(client);
  await DatabaseService.init(client);
  SongRecognitionService.init(client, DatabaseService.instance);
  BootUpService.init(client, DatabaseService.instance);

  client.onReady.listen((_) async {
    await usage?.sendEvent('main:setup', 'complete');
  });

  // Connect
  await client.connect();
}
