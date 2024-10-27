import 'dart:io';

import 'package:args/args.dart';
import 'package:yaml_edit/yaml_edit.dart';

// A tool that automatically edits the lavalink.yml file to populate the
// following environment variables:
//
// 1. LAVALINK_PASSWORD
// 2. YOUTUBE_OAUTH_REFRESH_TOKEN
// 3. DEEZER_MASTER_DECRYPTION_KEY
//
// The lavalink.yml file is expected to be in the same directory as this file.
// The environment variables are expected to be in a .env file in the .env
// directory, with the following structure:
//
// .env
// ├── .env.development
// └── .env.production
//
void main(List<String> args) {
  final parser = ArgParser()
    ..addOption(
      'input',
      abbr: 'i',
      defaultsTo: 'lavalink.yml',
      help: 'Input file path',
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'Output file path (defaults to the input file)',
    )
    ..addOption(
      'lavalink-password',
      help: 'Lavalink password. Will default to the '
          'LAVALINK_PASSWORD environment variable.',
    )
    ..addOption(
      'youtube-oauth-refresh-token',
      help: 'YouTube OAuth refresh token. Will default to the '
          'YOUTUBE_OAUTH_REFRESH_TOKEN environment variable.',
    )
    ..addOption(
      'deezer-master-decryption-key',
      help: 'Deezer master decryption key. Will default to the '
          'DEEZER_MASTER_DECRYPTION_KEY environment variable.',
    )
    ..addFlag(
      'clear',
      negatable: false,
      help: 'Clears the existing configuration on the file. '
          'This is useful to run before commiting anything.',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Display this help message',
    );

  final argResults = parser.parse(args);

  if (argResults['help'] as bool) {
    stdout.writeln('Usage: dart script.dart [options]');
    stdout.writeln(parser.usage);
    exit(0);
  }

  final clear = argResults['clear'] as bool? ?? false;

  // Retrieve the file paths
  final inputFilePath = argResults['input'] as String;
  final outputFilePath = argResults['output'] as String? ?? inputFilePath;

  // Helper function to get environment variable or command-line argument
  String? getEnvOrArg(String argName, String envName) {
    if (clear) return null;
    return argResults[argName] as String? ?? Platform.environment[envName];
  }

  // Retrieve the environment variables
  final lavalinkPassword =
      getEnvOrArg('lavalink-password', 'LAVALINK_PASSWORD');
  final youtubeOAuthRefreshToken =
      getEnvOrArg('youtube-oauth-refresh-token', 'YOUTUBE_OAUTH_REFRESH_TOKEN');
  final deezerMasterDecryptionKey = getEnvOrArg(
    'deezer-master-decryption-key',
    'DEEZER_MASTER_DECRYPTION_KEY',
  );

  // Ensure required variables are not null
  if ((lavalinkPassword == null ||
          youtubeOAuthRefreshToken == null ||
          deezerMasterDecryptionKey == null) &&
      !clear) {
    stderr
      ..writeln('Error: Missing required environment variables.')
      ..writeln(
        'Please provide them via command-line '
        'arguments or environment variables.',
      );

    exit(1);
  }

  final inputFile = File(inputFilePath);
  if (!inputFile.existsSync()) {
    stderr.writeln('Error: Input file "$inputFilePath" does not exist.');
    exit(1);
  }

  final content = inputFile.readAsStringSync();

  // Create a YamlEditor
  final editor = YamlEditor(content);

  // Helper function to ensure a path exists
  void ensurePathExists(List<Object> path) {
    for (var i = 1; i <= path.length; i++) {
      final subPath = path.sublist(0, i);
      try {
        editor.parseAt(subPath);
      } catch (e) {
        // If the path doesn't exist, create it
        editor.update(subPath, {});
      }
    }
  }

  ensurePathExists(['lavalink', 'server']);
  editor.update(
    ['lavalink', 'server', 'password'],
    lavalinkPassword,
  );

  ensurePathExists(['plugins', 'youtube', 'oauth']);
  editor.update(
    ['plugins', 'youtube', 'oauth', 'refreshToken'],
    youtubeOAuthRefreshToken,
  );

  ensurePathExists(['plugins', 'lavasrc', 'deezer']);
  editor.update(
    ['plugins', 'lavasrc', 'deezer', 'masterDecryptionKey'],
    deezerMasterDecryptionKey,
  );

  final newContent = editor.toString();

  final outputFile = File(outputFilePath);
  outputFile.deleteSync(recursive: true);
  outputFile.createSync(recursive: true);

  outputFile.writeAsStringSync(newContent);

  stdout
      .writeln('lavalink.yml file updated successfully at "$outputFilePath".');
}
