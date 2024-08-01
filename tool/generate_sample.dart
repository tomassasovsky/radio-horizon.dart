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

  final outputFile = File(outputPath);
  if (!outputFile.existsSync()) await outputFile.create();

  final sink = outputFile.openWrite();
  final completer = Completer<void>();
  final bitRate = radio.bitrate;
  final bytePerSecond = bitRate / 8 * 1000;
  final expectedBytes = bytePerSecond * durationInSeconds;

  StreamSubscription<List<int>>? streamSubscription;
  streamSubscription = response.stream.listen(
    (chunk) async {
      sink.add(chunk);
      final bytes = await outputFile.length();
      if (bytes >= expectedBytes) {
        await streamSubscription?.cancel();
        await sink.close();
        if (!completer.isCompleted) {
          completer.complete();
        }
      }
    },
    onDone: () async {
      await sink.close();
      if (!completer.isCompleted) {
        completer.complete();
      }
    },
    onError: (Object error) async {
      await streamSubscription?.cancel();
      await sink.close();
      if (!completer.isCompleted) {
        completer.completeError(error);
      }
    },
    cancelOnError: true,
  );

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
