// Copyright (c) 2022, Jorge Rincón Arias
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:io';

import 'package:acrcloud_rest/acrcloud_rest.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nyxx/nyxx.dart';
import 'package:radio_garden/radio_garden.dart';
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

  static final SongRecognitionOptions _options = SongRecognitionOptions(
    accessKey: arcCloudAccessKey,
    accessSecret: arcCloudAccessSecret,
    host: arcCloudHost,
  );

  Uuid get uuid => const Uuid();

  http.Client get httpClient =>
      _httpClient ??
      (throw RadioCantCommunicateWithServer(
        Exception('Http Client must be initialized'),
      ));

  // HttpClient used to get the sample
  final http.Client? _httpClient;

  final List<GuildRadio> _guildRadiosList = [];

  /// Gets the current radio playing by Guild.
  ///
  /// Throws [RadioNotPlayingException] if the Guild is not listening
  /// to the radio
  GuildRadio currentRadio(String guildId) {
    if (guildId.isEmpty) {
      throw const RadioNotPlayingException();
    }
    return _guildRadiosList.firstWhere(
      (element) => element.guildId == guildId,
      orElse: () => throw const RadioNotPlayingException(),
    );
  }

  /// Adds or not the current radio that the guild is playing
  void setCurrentRadio(String guildId, RadioGardenSearchResponse radio) {
    final newRadio = GuildRadio(guildId: guildId, radio: radio);
    final radioIndex = _guildRadiosList
        .indexWhere((element) => element.guildId == newRadio.guildId);

    if (radioIndex < 0) {
      _guildRadiosList.add(newRadio);
    } else {
      _guildRadiosList[radioIndex] = newRadio;
    }
  }

  /// Deletes the radio from the [SongRecognitionService] radio. This is to let
  /// the service know that the guild is no longer listening to the radio.
  void deleteRadioFromList(String guildId) {
    _guildRadiosList.removeWhere((e) => e.guildId == guildId);
  }

  /// Identifies the current song playing in the radio.
  ///
  /// Receives a [radioId] to identify the radio and a [durationInSeconds] to
  /// grab that amount of time of the sample from the radio.
  Future<Music> identify(String radioId, int? durationInSeconds) async {
    final songFile = await generateSample(
      radioId: radioId,
      durationInSeconds: durationInSeconds ?? 10,
    );

    final sample = await songFile.readAsBytes();

    try {
      final result = await ACRCloudRest().recogniseSong(
        sample,
        options: _options,
      );

      final track = result.metadata?.music?.first;

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
    required String radioId,
    int durationInSeconds = 10,
  }) async {
    final completer = Completer<File>();

    final url =
        'https://radio.garden/api/ara/content/listen/$radioId/channel.mp3';
    final uri = Uri.parse(url);

    final request = http.Request('GET', uri);
    StreamedResponse? response;
    try {
      response = await httpClient.send(request);
    } catch (e) {
      throw RadioCantCommunicateWithServer(Exception(e.toString()));
    }

    StreamSubscription<List<int>>? streamSubscription;

    final responseBitRate = response.headers['icy-br'] ?? '128';

    final bitRate = num.parse(responseBitRate).toInt();
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
          await sink.flush();
          await sink.close();

          await streamSubscription?.cancel();
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
}
