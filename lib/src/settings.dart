// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';
import 'package:nyxx/nyxx.dart';
import 'package:radio_horizon/radio_horizon.dart';

/// Get a [String] from an environment variable,
/// throwing an exception if it is not set.
///
/// If [def] is provided and the environment variable [key] is not set,
/// [def] will be returned instead of throwing an exception.
String getEnv(String key, [String? def]) =>
    dotEnvFlavour.dotenv[key] ??
    Platform.environment[key] ??
    def ??
    (throw Exception('Missing `$key` environment variable'));

/// Get a [String] from an environment variable,
/// returning `null` if it is not set.
///
/// If [def] is provided and the environment variable [key] is not set,
/// [def] will be returned instead of `null`.
String? maybeGetEnv(String key, [String? def]) =>
    dotEnvFlavour.dotenv[key] ?? Platform.environment[key] ?? def;

/// Get a [bool] from an environment variable,
/// throwing an exception if it is not set.
///
/// If [def] is provided and the environment variable [key] is not set,
/// [def] will be returned instead of throwing an exception.
bool getEnvBool(String key, {bool? def}) =>
    ['true', '1'].contains(getEnv(key, def?.toString()).toLowerCase());

/// The token to use for this instance.
final String token = getEnv('RG_TOKEN');

/// The prefix to use for text commands for this instance.
final String prefix = getEnv('RG_PREFIX');

/// The IDs of the users that are allowed to use administrator commands
final List<Snowflake> adminIds =
    getEnv('RG_ADMIN_IDS').split(RegExp(r'\s+')).map(Snowflake.parse).toList();

/// The default response for the github command.
final String defaultGithubResponse = getEnv(
  'RG_DEFAULT_GITHUB_RESPONSE',
  '''
Radio Horizon Bot is an open source project hosted on GitHub.
''',
);

/// The GitHub account to use when no other account is specified.
final String githubAccount = getEnv('RG_GITHUB_ACCOUNT', 'tomassasovsky');

/// The GitHub Personal Access Token to use
/// when authenticating with the GitHub API.
final String githubToken = getEnv('RG_GITHUB_TOKEN');

/// Whether this instance should run in development mode.
final bool dev = getEnvBool('RG_DEV');

/// If this instance is in development mode,
/// the ID of the guild to register commands to, else `null`.
final devGuildId = dev ? Snowflake.parse(getEnv('RG_DEV_GUILD_ID')) : null;

/// The bot's app id.
final clientId = Snowflake.parse(getEnv('CLIENT_ID'));

/// The address of the lavalink running server to connect to.
String lavalinkAddress = getEnv('LAVALINK_ADDRESS');

/// The port of the lavalink running server to use to connect.
int lavalinkPort = int.parse(getEnv('LAVALINK_PORT'));

/// The password used to connect to the lavalink server.
String lavalinkPassword = getEnv('LAVALINK_PASSWORD');

/// Whether to use or not ssl to establish a connection.
bool lavalinkUseSSL = getEnvBool('LAVALINK_USE_SSL', def: false);

/// The Sentry DSN to use for this instance.
String sentryDsn = getEnv('SENTRY_DSN');

/// The basic intents needed to run Radio Horizon without privileged intents.
final intents = GatewayIntents.directMessages |
    GatewayIntents.guilds |
    GatewayIntents.guildVoiceStates;

/// Your MongoDB connection string.
///
/// Find yours in https://www.mongodb.com/cloud/atlas.
/// You can also use a local MongoDB instance.
String mongoDBConnection = getEnv('MONGO_CONNECTION');

const botIconUrl =
    'https://cdn.discordapp.com/app-icons/977793621896093736/bed9c0abf5b7f4980024b4ad82a18a15.png?size=256';

const githubUrl = 'https://github.com/tomassasovsky/radio-horizon.dart';
