// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:injector/injector.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:sentry/sentry.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:shazam_client/shazam_client.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    dotEnvFlavour = DotEnvFlavour.production;
    dotEnvFlavour.initialize();

    await Sentry.init(
      (options) {
        options
          ..dsn = sentryDsn
          ..environment = dotEnvFlavour.name
          ..release = packageVersion
          ..debug = dotEnvFlavour == DotEnvFlavour.development
          ..attachStacktrace = true
          ..sampleRate = 1.0
          ..sendDefaultPii = true
          ..tracesSampleRate = 1.0
          ..addIntegration(LoggingIntegration());
      },
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

    final commands = CommandsPlugin(
      prefix: mentionOr((_) => prefix),
      options: const CommandsOptions(
        logErrors: false,
      ),
    )
      ..addCommand(info)
      // ..addCommand(skip)
      // ..addCommand(stop)
      // ..addCommand(join)
      // ..addCommand(leave)
      // ..addCommand(pause)
      // ..addCommand(resume)
      // ..addCommand(volume)
      ..addCommand(music);
    // ..addCommand(radio);

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
      ..registerSingleton(() => lavalinkPlugin);

    await Injector.appInstance.get<BotStartDuration>().init();
    await Injector.appInstance.get<DatabaseService>().init();
    await Injector.appInstance.get<BootUpService>().init();
  }, (exception, stackTrace) async {
    Logger('main').severe(
      'Uncaught exception when initialising the bot',
      exception,
      stackTrace,
    );
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}
