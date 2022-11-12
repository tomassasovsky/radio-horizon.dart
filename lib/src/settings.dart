// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';
import 'package:nyxx/nyxx.dart';
import 'package:radio_garden/radio_garden.dart';

/// Get a [String] from an environment variable,
/// throwing an exception if it is not set.
///
/// If [def] is provided and the environment variable [key] is not set,
/// [def] will be returned instead of throwing an exception.
String getEnv(String key, [String? def]) =>
    Platform.environment[key] ??
    def ??
    dotEnvFlavour.dotenv[key] ??
    (throw Exception('Missing `$key` environment variable'));

/// Get a [bool] from an environment variable,
/// throwing an exception if it is not set.
///
/// If [def] is provided and the environment variable [key] is not set,
/// [def] will be returned instead of throwing an exception.
bool getEnvBool(String key, {bool? def}) =>
    ['true', '1'].contains(getEnv(key, def?.toString()).toLowerCase());

/// The token to use for this instance.
final String token = getEnv('RG_TOKEN');

/// Whether to enable features requiring privileged intents for this instance.
final bool intentFeaturesEnabled = getEnvBool('RG_INTENT_FEATURES_ENABLE');

/// The prefix to use for text commands for this instance.
final String prefix = getEnv('RG_PREFIX');

/// The IDs of the users that are allowed to use administrator commands
final List<Snowflake> adminIds =
    getEnv('RG_ADMIN_IDS').split(RegExp(r'\s+')).map(Snowflake.new).toList();

/// The interval at which to update the docs cache.
// final Duration docsUpdateInterval =
//     Duration(seconds: int.parse(getEnv('RG_DOCS_UPDATE_INTERVAL', '900')));

/// The default response for the github command.
final String defaultGithubResponse = getEnv('RG_DEFAULT_GITHUB_RESPONSE', '''
Radio Garden Bot is an open source project hosted on GitHub.
''');

/// The GitHub account to use when no other account is specified.
final String githubAccount = getEnv('RG_GITHUB_ACCOUNT', 'tomassasovsky');

/// The GitHub Personal Access Token to use
/// when authenticating with the GitHub API.
final String githubToken = getEnv('RG_GITHUB_TOKEN');

/// Whether this instance should run in development mode.
final bool dev = getEnvBool('RG_DEV');

/// If this instance is in development mode,
/// the ID of the guild to register commands to, else `null`.
final guildId = Snowflake(getEnv('RG_DEV_GUILD_ID'));

/// The address of the lavalink running server to connect to.
String serverAddress = getEnv('LAVALINK_ADDRESS');

/// The port of the lavalink running server to use to connect.
int serverPort = int.parse(getEnv('LAVALINK_PORT'));

/// The password used to connect to the lavalink server.
String serverPassword = getEnv('LAVALINK_PASSWORD');

/// Whether to use or not ssl to establish a connection.
bool useSSL = getEnvBool('LAVALINK_USE_SSL', def: false);

/// The basic intents needed to run Running on Dart without privileged intents.
const int _baseIntents = GatewayIntents.directMessages |
    GatewayIntents.guilds |
    GatewayIntents.guildVoiceState;

/// Privileged intents that can be enabled
/// to add additional features to Running on Dart.
const int _privilegedIntents =
    _baseIntents | GatewayIntents.guildMessages | GatewayIntents.guildMembers;

/// The intents to use for this instance.
final int intents = intentFeaturesEnabled ? _privilegedIntents : _baseIntents;
