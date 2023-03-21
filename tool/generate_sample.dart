import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:radio_browser_api/radio_browser_api.dart';

Future<void> generateSample({
  required Station radio,
  required String outputPath,
  int durationInSeconds = 10,
}) async {
  final url = radio.urlResolved ?? radio.url;
  final uri = Uri.parse(url);

  final client = http.Client();
  final request = http.Request('GET', uri);
  final response = await client.send(request);

  StreamSubscription<List<int>>? streamSubscription;

  final bitRate = radio.bitrate;

  final outputFile = File(outputPath);
  if (!outputFile.existsSync()) outputFile.createSync();
  final sink = outputFile.openWrite();

  final completer = Completer<void>();

  streamSubscription = response.stream.listen((chunk) async {
    final bytes = await outputFile.length();

    if (bytes > 0) {
      // we can calculate the duration by using the bitrate and the file size,
      // the formula is found here:
      // http://www.audiomountain.com/tech/audio-file-size.html
      final bytePerSecond = bitRate / 8 * 1000;
      final expectedBytes = bytePerSecond * durationInSeconds;

      if (expectedBytes < bytes) {
        await sink.flush();
        await sink.close();

        await streamSubscription?.cancel();
        if (!completer.isCompleted) {
          completer.complete();
        }
        return;
      }
    }

    sink.add(chunk);
  });

  return completer.future;
}

Future<void> main(List<String> args) async {
  final stopwatch = Stopwatch()..start();
  log('Generating sample...');

  await generateSample(
    outputPath: 'sample.mp3',
    radio: Station(
      changeUUID: '',
      stationUUID: '',
      serverUUID: '',
      name: "America's Greatest 80s Hits",
      url: 'https://ais-edge49-nyc04.cdnstream.com/2281_128.mp3',
      urlResolved: null,
      homepage: null,
      favicon: null,
      tags: null,
      country: '',
      countryCode: '',
      state: null,
      language: null,
      languageCodes: null,
      votes: 0,
      lastChangeTime: DateTime(2023),
      codec: null,
      bitrate: 128,
      hls: false,
      lastCheckOk: true,
      lastCheckTime: null,
      lastCheckOkTime: null,
      lastLocalCheckTime: null,
      clickTimestamp: null,
      clickCount: 10,
      clickTrend: 10,
      sslError: false,
      geoLat: null,
      geoLong: null,
      hasExtendedInfo: false,
    ),
  );

  log('Done in ${stopwatch.elapsedMilliseconds}ms');
}
