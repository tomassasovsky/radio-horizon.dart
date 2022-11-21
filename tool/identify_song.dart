// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:radio_garden/radio_garden.dart';

Future<ShazamSongRecognition> identify(Uint8List data) async {
  final sample = data.buffer.asUint8List();

  final uri = Uri(
    scheme: 'https',
    host: 'shazam-song-recognizer.p.rapidapi.com',
    path: 'recognize',
  );

  final request = http.MultipartRequest('POST', uri);

  request.headers.addAll({
    'X-RapidAPI-Key': 'YOUR_KEY',
    'X-RapidAPI-Host': 'shazam-song-recognizer.p.rapidapi.com',
  });

  request.files.add(
    http.MultipartFile.fromBytes(
      'upload_file',
      sample,
    ),
  );

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);
  return ShazamSongRecognition.fromJson(
    (jsonDecode(response.body) as Map).cast(),
  );
}

Future<void> main(List<String> args) async {
  dotEnvFlavour = DotEnvFlavour.development;
  await dotEnvFlavour.initialize();

  final stopwatch = Stopwatch()..start();
  log('Recognizing song...');

  final fileContents = File('sample.mp3').readAsBytesSync();
  final result = await identify(fileContents);

  log('Done in ${stopwatch.elapsedMilliseconds}ms');
  final track = result.result;
  log(
    track == null
        ? 'No song found'
        : 'Song found: ${'${track.title} - ${track.subtitle}'}',
  );
  log(track!.share!.image!);
}
