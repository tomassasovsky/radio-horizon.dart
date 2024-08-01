// Copyright (c) 2022, Jorge Rincón Arias
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:radio_horizon/radio_horizon.dart';
import 'package:radio_horizon/src/models/song_recognition/current_station_info.dart';
import 'package:shazam_client/shazam_client.dart';
import 'package:uuid/uuid.dart';

class SongRecognitionService {
  SongRecognitionService(this._shazamClient);

  Uuid get uuid => const Uuid();

  ShazamClient get shazamClient => _shazamClient;

  // ShazamClient used to get the sample
  final ShazamClient _shazamClient;

  final http.Client httpClient = http.Client();

  Future<CurrentStationInfo> getCurrentStationInfo(
    GuildRadio radio,
  ) async {
    final radioUrl = radio.station.urlResolved ?? radio.station.url;

    final uri = Uri(
      scheme: 'https',
      host: 'service.radiolise.com',
      queryParameters: {
        'url': radioUrl,
      },
    );

    final response = await httpClient.get(uri);

    return CurrentStationInfo.fromJson(
      (jsonDecode(response.body) as Map).cast(),
    );
  }

  /// Identifies the current song playing in the radio.
  ///
  /// Receives a [url] to identify the radio and a [durationInSeconds] to
  /// grab that amount of time of the sample from the radio.
  Future<SongModel> identify(
    String url,
    int? durationInSeconds,
  ) async {
    final songFile = await generateSample(
      url: url,
      durationInSeconds: durationInSeconds ?? 10,
    );

    try {
      final response = await shazamClient.recognizeSong(songFile);
      final track = response;

      // Deletes the file after the recognition is done
      songFile.deleteSync();

      return track;
    } on RadioCantIdentifySongException {
      rethrow;
    } catch (e) {
      throw RadioCantCommunicateWithServer(Exception(e.toString()));
    }
  }

  /// Generates a sample file used to identify the song playing.
  ///
  /// Returns a [File] stored in the /tmp directory.
  Future<File> generateSample({
    required String url,
    int durationInSeconds = 10,
  }) async {
    final completer = Completer<File>();

    final uri = Uri.parse(url);
    final request = http.Request('GET', uri);
    http.StreamedResponse response;
    try {
      response = await httpClient.send(request);
    } catch (e) {
      throw RadioCantCommunicateWithServer(Exception(e.toString()));
    }

    final responseBitRate = response.headers['icy-br'] ?? '128';
    final bitRate = num.parse(responseBitRate.split(',').first).toInt();
    final outputFile =
        File('${Directory.systemTemp.path}/${const Uuid().v4()}.mp3');
    if (!outputFile.existsSync()) await outputFile.create();

    final sink = outputFile.openWrite();
    final bytePerSecond = bitRate / 8 * 1024;
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
            completer.complete(outputFile);
          }
        }
      },
      onDone: () async {
        await sink.close();
        if (!completer.isCompleted) {
          completer.complete(outputFile);
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
}
