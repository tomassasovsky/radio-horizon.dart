// Copyright (c) 2022, Jorge Rincón Arias
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crypto/crypto.dart';
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

  GuildRadio currentRadio(String guildId) {
    if (guildId.isEmpty) {
      throw const RadioNotPlayingException();
    }
    return _guildRadiosList.firstWhere(
      (element) => element.guildId == guildId,
      orElse: () => throw const RadioNotPlayingException(),
    );
  }

  void setCurrentRadio(String guildId, RadioGardenSearchResponse radio) {
    final newRadio = GuildRadio(guildId: guildId, radio: radio);
    final radioIndex = _guildRadiosList
        .indexWhere((element) => element.guildId == newRadio.guildId);

    if (radioIndex < 0) {
      _guildRadiosList.add(newRadio);
    }
  }

  /// Identifies the current song playing in the radio.
  ///
  /// Receives a [radioId] to identify the radio.
  Future<String> identify(String radioId) async {
    final stopwatch = Stopwatch()..start();

    final songFile = await generateSample(radioId: radioId);
    final sample = songFile.readAsBytesSync()..buffer.asUint8List();

    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final stringToSign = buildStringToSign(
      'POST',
      _options.endpoint,
      _options.accessKey,
      _options.dataType,
      _options.signatureVersion,
      timestamp.toString(),
    );
    final signature = sign(stringToSign, _options.accessSecret);

    final uri = Uri(
      scheme: 'https',
      host: arcCloudHost,
      path: 'v1/identify',
    );

    final fields = {
      'access_key': _options.accessKey,
      'data_type': _options.dataType,
      'signature_version': _options.signatureVersion,
      'signature': signature,
      'sample_bytes': sample.length.toString(),
      'timestamp': timestamp.toString(),
    };

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(fields);
    request.files.add(http.MultipartFile.fromBytes('sample', sample));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final result = SongRecognitionResponse.fromJson(
        jsonDecode(response.body) as Map,
      );

      log('Done in ${stopwatch.elapsedMilliseconds}ms');
      final track = result.metadata?.music?.first;

      // Deletes the file after the recognition is done
      songFile.deleteSync();

      if (track == null) {
        throw const RadioCantIdentifySongException();
      }
      return 'Song found: ${'${track.title} - ${track.artists?.first.name}'}';
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

    final bitRate = int.parse(response.headers['icy-br'] ?? '128');
    final outputFile = File('${Directory.systemTemp.path}/${uuid.v4()}');
    if (!outputFile.existsSync()) outputFile.createSync();
    final sink = outputFile.openWrite();

    // we can calculate the duration by using the bitrate and
    // the file size, the formula is found here:
    // http://www.audiomountain.com/tech/audio-file-size.html
    final bytePerSecond = bitRate / 8 * 1000;
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

  String sign(String signString, String accessSecret) {
    return base64Encode(
      Hmac(sha1, utf8.encode(accessSecret))
          .convert(utf8.encode(signString))
          .bytes,
    );
  }

  String buildStringToSign(
    String method,
    String uri,
    String accessKey,
    String dataType,
    String signatureVersion,
    String timestamp,
  ) {
    return [method, uri, accessKey, dataType, signatureVersion, timestamp]
        .join('\n');
  }
}
