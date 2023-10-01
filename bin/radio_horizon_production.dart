// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:sentry/sentry.dart';
import 'package:sentry_logging/sentry_logging.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    await Sentry.init(
      (options) {
        options
          ..dsn = dotEnvFlavour.dotenv['SENTRY_DSN']
          ..tracesSampleRate = 1.0
          ..addIntegration(LoggingIntegration());
      },
    );

    dotEnvFlavour = DotEnvFlavour.production;
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
      ..registerPlugin(CliIntegration())
      ..registerPlugin(IgnoreExceptions())
      ..registerPlugin(commands);

    // Initialise our services
    MusicService.init(client);
    await DatabaseService.init(client);
    SongRecognitionService.init(client, DatabaseService.instance);
    BootUpService.init(client, DatabaseService.instance);

    // Connect
    await client.connect();
  }, (exception, stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}
