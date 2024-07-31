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
  SongRecognitionService._privateConstructor()
      : _shazamClient = ShazamClient.dockerized();

  static SongRecognitionService get instance => _instance;

  static final SongRecognitionService _instance =
      SongRecognitionService._privateConstructor();

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
    http.StreamedResponse? response;
    try {
      response = await httpClient.send(request);
    } catch (e) {
      throw RadioCantCommunicateWithServer(Exception(e.toString()));
    }

    StreamSubscription<List<int>>? streamSubscription;

    final responseBitRate = response.headers['icy-br'] ?? '128';

    final bitRate = num.parse(responseBitRate.split(',').first).toInt();
    final outputFile = File('${Directory.systemTemp.path}/${uuid.v4()}');
    if (!outputFile.existsSync()) outputFile.createSync();
    final sink = outputFile.openWrite();

    // we can calculate the duration by using the bitrate and
    // the file size, the formula is found here:
    // http://www.audiomountain.com/tech/audio-file-size.html
    final bytePerSecond = bitRate / 8 * 1024;
    final expectedBytes = bytePerSecond * durationInSeconds;

    streamSubscription = response.stream.listen((chunk) async {
      final bytes = await outputFile.length();

      if (bytes > 0) {
        if (expectedBytes < bytes) {
          unawaited(streamSubscription?.cancel());

          await sink.flush();
          await sink.close();

          if (!completer.isCompleted) {
            completer.complete(outputFile);
          }
          return;
        }
      }

      sink.add(chunk);
    });

    return completer.future;
  }

  /// Gets a list of links to different streaming services where the song
  /// is available.
  Future<MusicLinksResponse> getMusicLinks(String songName) async {
    final uri = Uri(
      scheme: 'https',
      host: 'musiclinkssapi.p.rapidapi.com',
      path: 'search/query',
      queryParameters: {
        'q': songName,
        'type': 'track',
      },
    );

    final request = http.Request('GET', uri);

    request.headers.addAll({
      'X-RapidAPI-Key': rapidapiShazamSongRecognizerKey,
      'X-RapidAPI-Host': 'musiclinkssapi.p.rapidapi.com',
    });

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    final decodedResponse = jsonDecode(response.body);
    if (decodedResponse is! Map || decodedResponse.isEmpty) {
      return MusicLinksResponse.empty();
    }

    final result = MusicLinksResponse.fromJson(
      (jsonDecode(response.body) as Map).cast(),
    );

    return result;
  }
}
