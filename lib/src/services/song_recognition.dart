// Copyright (c) 2022, Jorge Rincón Arias
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nyxx/nyxx.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:radio_horizon/src/models/song_recognition/current_station_info.dart';
import 'package:uuid/uuid.dart';

class SongRecognitionService {
  SongRecognitionService._(
    this.client,
    this.databaseService,
  ) : _httpClient = http.Client();

  static void init(INyxxWebsocket client, DatabaseService databaseService) {
    _instance = SongRecognitionService._(
      client,
      databaseService,
    );
  }

  final DatabaseService databaseService;
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

  /// Gets the current radio playing by Guild.
  ///
  /// Throws [RadioNotPlayingException] if the Guild is not listening
  /// to the radio
  Future<GuildRadio> currentRadio(Snowflake guildId) async {
    final currentlyPlaying = await databaseService.getPlaying(guildId);
    if (currentlyPlaying == null) {
      throw const RadioNotPlayingException();
    }

    return currentlyPlaying;
  }

  /// Adds or not the current radio that the guild is playing
  Future<void> setCurrentRadio(
    Snowflake guildId,
    Snowflake voiceChannelId,
    Snowflake textChannelId,
    Station station,
  ) async {
    final newRadio = GuildRadio(
      guildId,
      voiceChannelId: voiceChannelId,
      station: station,
      textChannelId: textChannelId,
    );

    await databaseService.setPlaying(newRadio);
  }

  /// Deletes the radio from the [SongRecognitionService] radio. This is to let
  /// the service know that the guild is no longer listening to the radio.
  Future<void> deleteRadioFromList(Snowflake guildId) async {
    await databaseService.setNotPlaying(guildId);
  }

  Future<CurrentStationInfo> getCurrentStationInfo(
    GuildRadio radio,
  ) async {
    final url = radio.station.urlResolved ?? radio.station.url;
    final headers = <String, String>{};

    final reqCompleter = Completer<void>();

    String? result;
    var icyMetaint = -1;
    const needleTitle = 'StreamTitle=';
    final req = await HttpClient().getUrl(Uri.parse(url))
      ..headers.add('Icy-MetaData', '1');
    final stream = await req.close();
    stream.headers.forEach((name, values) {
      headers[name.toLowerCase()] = values.join(',');
    });
    icyMetaint = int.tryParse(headers['icy-metaint'] ?? '') ?? -1;

    if (icyMetaint != -1) {
      var offset = icyMetaint;
      stream.listen((buffer) async {
        if (result == null) {
          final bufferString = utf8.decode(buffer, allowMalformed: true);
          if (bufferString.contains(needleTitle)) {
            final title =
                bufferString.split(needleTitle)[1].trim().substring(1);
            result = title.substring(0, title.indexOf("';"));
            if (!bufferString.contains('adw_ad')) {
              await req.close();
            }
            reqCompleter.complete();
          } else if (offset == icyMetaint) {
            await req.close();
          }
          offset += icyMetaint;
        }
      });
    }

    await reqCompleter.future;

    const needleText = '- text="';
    if (result == null) {
      final req2 = await HttpClient()
          .getUrl(Uri.parse('$url/7'))
          .timeout(const Duration(seconds: 10));
      final stream2 = await req2.close();
      final data = await stream2
          .transform(const Utf8Decoder(allowMalformed: true))
          .join();
      final title = data.split(',')[6].substring(0, data.indexOf('<'));
      result = title;
      if (result?.contains(needleText) ?? false) {
        final ihsplit = result?.split(needleText);
        final artist = ihsplit?[0].trim();
        final song = ihsplit?[1].substring(0, ihsplit[1].indexOf('" ')).trim();
        result = '$artist - $song';
      }
      return CurrentStationInfo(
        description: headers['icy-description'],
        genre: headers['icy-genre'],
        name: headers['icy-name'],
        title: result,
        url: headers['icy-url'],
      );
    } else {
      if (result?.contains(needleText) ?? false) {
        final ihsplit = result?.split(needleText);
        final artist = ihsplit?[0].trim();
        final song = ihsplit?[1].substring(0, ihsplit[1].indexOf('" ')).trim();
        result = '$artist - $song';
      }

      return CurrentStationInfo(
        title: result,
        description: headers['icy-description'],
        genre: headers['icy-genre'],
        name: headers['icy-name'],
        url: headers['icy-url'],
      );
    }
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
      path: 'api',
      queryParameters: {
        'query': songName,
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
    final result = MusicLinksResponse.fromJson(
      (jsonDecode(response.body) as Map).cast(),
    );

    return result;
  }
}
