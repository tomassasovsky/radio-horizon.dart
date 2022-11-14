import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> generateSample({
  required String radioId,
  required String outputPath,
  int durationInSeconds = 10,
}) async {
  final url =
      'https://radio.garden/api/ara/content/listen/$radioId/channel.mp3';
  final uri = Uri.parse(url);

  final client = http.Client();
  final request = http.Request('GET', uri);
  final response = await client.send(request);

  StreamSubscription<List<int>>? streamSubscription;

  final bitRate = int.parse(response.headers['icy-br'] ?? '128');

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
    radioId: '-AE_qyMq',
  );

  log('Done in ${stopwatch.elapsedMilliseconds}ms');
}
