// // Copyright (c) 2022, Tomás Sasovsky
// //
// // Use of this source code is governed by an MIT-style
// // license that can be found in the LICENSE file or at
// // https://opensource.org/licenses/MIT.

// import 'package:nyxx/nyxx.dart';
// import 'package:radio_horizon/radio_horizon.dart';

// Future<void> main(List<String> args) async {
//   dotEnvFlavour = DotEnvFlavour.development;
//   dotEnvFlavour.initialize();

//   final bot = NyxxFactory.createNyxxWebsocket(
//     token,
//     GatewayIntents.allUnprivileged,
//   )
//     ..registerPlugin(Logging()) // Default logging plugin
//     ..registerPlugin(CliIntegration())
//     ..registerPlugin(IgnoreExceptions());

//   // final interactions = IInteractions.create(WebsocketInteractionBackend(bot))
//   //   ..syncOnReady();

//   await bot.connect();

//   // await interactions.interactionsEndpoints.bulkOverrideGuildCommands(
//   //   clientId!,
//   //   devGuildId!,
//   //   [],
//   // ).toList();

//   await bot.dispose();
// }
