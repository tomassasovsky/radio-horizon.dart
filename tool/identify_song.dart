// ignore_for_file: avoid_print

import 'dart:io';

import 'package:radio_horizon/radio_horizon.dart';
import 'package:shazam_client/shazam_client.dart';

Future<void> main(List<String> args) async {
  dotEnvFlavour = DotEnvFlavour.development;
  dotEnvFlavour.initialize();

  final stopwatch = Stopwatch()..start();
  print('Recognizing song...');

  final fileContents = File('sample.mp3');
  final result = await ShazamClient.dockerized().recognizeSong(fileContents);

  print('Done in ${stopwatch.elapsedMilliseconds}ms');
  final track = result;
  print('Song found: ${'${track.title} - ${track.subtitle}'}');
  print(track.share!.image);
}
