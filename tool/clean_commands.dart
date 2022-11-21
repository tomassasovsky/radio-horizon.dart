// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_garden/radio_garden.dart';

Future<void> main(List<String> args) async {
  dotEnvFlavour = DotEnvFlavour.development;
  await dotEnvFlavour.initialize();

  final bot = NyxxFactory.createNyxxWebsocket(
    token,
    GatewayIntents.allUnprivileged,
  )
    ..registerPlugin(Logging()) // Default logging plugin
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions());

  final interactions = IInteractions.create(WebsocketInteractionBackend(bot))
    ..syncOnReady();

  await bot.connect();

  await interactions.interactionsEndpoints.bulkOverrideGlobalCommands(
    clientId!,
    [],
  ).toList();

  await bot.dispose();
}
