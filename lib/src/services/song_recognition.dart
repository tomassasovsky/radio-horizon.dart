// Copyright (c) 2022, Jorge Rincón Arias
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nyxx/nyxx.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:uuid/uuid.dart';

class SongRecognitionService {
  SongRecognitionService._(
    this.client,
  ) : _httpClient = http.Client();

  static void init(INyxxWebsocket client) {
    _instance = SongRecognitionService._(
      client,
    );
  }

  final INyxxWebsocket client;

  static SongRecognitionService get instance =>
      _instance ??
      (throw Exception('Song Recognition service must be initialised'));
  static SongRecognitionService? _instance;

  Uuid get uuid => const Uuid();

  http.Client get httpClient =>
      _httpClient ??
      (throw RadioCantCommunicateWithServer(
        Exception('Http Client must be initialized'),
      ));

  // HttpClient used to get the sample
  final http.Client? _httpClient;

  final LinkedHashMap<Snowflake, GuildRadio> _guildRadiosList = LinkedHashMap();

  /// Gets the current radio playing by Guild.
  ///
  /// Throws [RadioNotPlayingException] if the Guild is not listening
  /// to the radio
  GuildRadio currentRadio(Snowflake guildId) {
    if (!_guildRadiosList.containsKey(guildId)) {
      throw const RadioNotPlayingException();
    }

    final value = _guildRadiosList[guildId];
    return value ?? (throw const RadioNotPlayingException());
  }

  /// Adds or not the current radio that the guild is playing
  void setCurrentRadio(Snowflake guildId, Station station) {
    final newRadio = GuildRadio(guildId, station: station);
    final radio = _guildRadiosList[guildId];

    if (radio == null) {
      _guildRadiosList.addAll({
        newRadio.id: newRadio,
      });
    } else {
      _guildRadiosList[newRadio.id] = newRadio;
    }
  }

  /// Deletes the radio from the [SongRecognitionService] radio. This is to let
  /// the service know that the guild is no longer listening to the radio.
  void deleteRadioFromList(Snowflake guildId) {
    _guildRadiosList.remove(guildId);
  }

  /// Identifies the current song playing in the radio.
  ///
  /// Receives a [url] to identify the radio and a [durationInSeconds] to
  /// grab that amount of time of the sample from the radio.
  Future<ShazamResult> identify(
    String url,
    int? durationInSeconds,
  ) async {
    final songFile = await generateSample(
      url: url,
      durationInSeconds: durationInSeconds ?? 10,
    );

    final sample = await songFile.readAsBytes();

    try {
      final uri = Uri(
        scheme: 'https',
        host: 'shazam-song-recognizer.p.rapidapi.com',
        path: 'recognize',
      );

      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        'X-RapidAPI-Key': rapidapiShazamSongRecognizerKey,
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
      final result = ShazamSongRecognition.fromJson(
        (jsonDecode(response.body) as Map).cast(),
      );

      final track = result.result;

      // Deletes the file after the recognition is done
      songFile.deleteSync();

      return track ?? (throw const RadioCantIdentifySongException());
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
      path: 'apiSearch/track',
      queryParameters: {
        'query': songName,
      },
    );

    final request = http.Request('GET', uri);

    request.headers.addAll({
      'X-RapidAPI-Key': rapidapiShazamSongRecognizerKey,
      'X-RapidAPI-Host': 'musiclinkssapi.p.rapidapi.com',
    });

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final result = MusicLinksResponse.fromJson(
      (jsonDecode(response.body) as Map).cast(),
    );

    return result;
  }
}
