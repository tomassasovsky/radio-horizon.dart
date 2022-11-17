// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';
import 'package:nyxx/nyxx.dart';
import 'package:radio_garden/radio_garden.dart';
import 'package:usage/usage_io.dart';

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
    getEnv('RG_ADMIN_IDS').split(RegExp(r'\s+')).map(Snowflake.new).toList();

/// The default response for the github command.
final String defaultGithubResponse = getEnv(
  'RG_DEFAULT_GITHUB_RESPONSE',
  '''
Radio Garden Bot is an open source project hosted on GitHub.
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
final devGuildId = dev ? Snowflake(getEnv('RG_DEV_GUILD_ID')) : null;

/// The bot's app id.
final clientId = dev ? Snowflake(getEnv('CLIENT_ID')) : null;

/// The address of the lavalink running server to connect to.
String serverAddress = getEnv('LAVALINK_ADDRESS');

/// The port of the lavalink running server to use to connect.
int serverPort = int.parse(getEnv('LAVALINK_PORT'));

/// The password used to connect to the lavalink server.
String serverPassword = getEnv('LAVALINK_PASSWORD');

/// Whether to use or not ssl to establish a connection.
bool useSSL = getEnvBool('LAVALINK_USE_SSL', def: false);

/// The host for the song recognition service, in ARCCloud.
///
/// Find yours in https://console.acrcloud.com/
String arcCloudHost = getEnv('ARC_CLOUD_HOST');

/// The access key for the song recognition service, in ARCCloud.
///
/// Find yours in https://console.acrcloud.com/
String arcCloudAccessKey = getEnv('ARC_CLOUD_ACCESS_KEY');

/// The access secret for the song recognition service, in ARCCloud.
///
/// Find yours in https://console.acrcloud.com/
String arcCloudAccessSecret = getEnv('ARC_CLOUD_ACCESS_SECRET');

/// Your Google Analytics Tracking ID.
///
/// Find yours in https://analytics.google.com/analytics/web/, by creating
/// a Universal Analytics property.
String? googleAnalyticsTrackingId = maybeGetEnv('ANALYTICS_TRACKING_ID');

/// The Google Analytics client.
///
/// This is used to send usage statistics to Google Analytics.
final usage = googleAnalyticsTrackingId == null
    ? null
    : AnalyticsIO(
        googleAnalyticsTrackingId!,
        'radio-garden.dart',
        packageVersion,
      );

/// The basic intents needed to run Radio Garden without privileged intents.
const int intents = GatewayIntents.directMessages |
    GatewayIntents.guilds |
    GatewayIntents.guildVoiceState;
