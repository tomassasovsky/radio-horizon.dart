// Copyright (c) 2022, Tomás Sasovsky
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
import 'package:nyxx/nyxx.dart';
import 'package:radio_garden/radio_garden.dart';
import 'package:radio_garden/src/models/radio_garden_response.dart';
import 'package:radio_garden/src/models/song_recognition/index.dart';

import 'package:uuid/uuid.dart';

class SongRecognitionService {
  SongRecognitionService._(
    this._client,
    this._musicService,
  ) {
    _client.onReady.listen((_) async {
      _httpClient ??= http.Client();
      _musicService ??= musicService;
    });
  }

  static void init(INyxxWebsocket client, MusicService musicService) {
    _instance = SongRecognitionService._(client, musicService);
  }

  MusicService get musicService =>
      _musicService ??
      (throw Exception(
        'Music service must be initialised',
      ));

  MusicService? _musicService;

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

  final INyxxWebsocket _client;

  http.Client get httpClient =>
      _httpClient ??
      (throw Exception('Http Client must be accessed after `on_ready` event'));

  /// The cluster used to interact with lavalink
  http.Client? _httpClient;

  RadioGardenSearchResponse? _currentRadio;

  RadioGardenSearchResponse get currentRadio =>
      _currentRadio ?? (throw Exception('Radio must be assigned'));

  set currentRadio(RadioGardenSearchResponse radio) => _currentRadio = radio;

  /// Generates a sample file used to identify the song playing.
  ///
  /// Returns a [File] stored in the /tmp directory.
  Future<File> generateSample({
    String radioId = '-AE_qyMq',
    int durationInSeconds = 10,
  }) async {
    final url =
        'https://radio.garden/api/ara/content/listen/$radioId/channel.mp3';
    final uri = Uri.parse(url);

    final request = http.Request('GET', uri);
    final response = await httpClient.send(request);

    StreamSubscription<List<int>>? streamSubscription;

    final bitRate = int.parse(response.headers['icy-br'] ?? '128');
    final outputFile = File('${Directory.systemTemp.path}/${uuid.v4()}');
    if (!outputFile.existsSync()) outputFile.createSync();
    final sink = outputFile.openWrite();

    final completer = Completer<File>();

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
            completer.complete(outputFile);
          }
          return;
        }
      }

      sink.add(chunk);
    });

    return completer.future;
  }

  Future<String> identify(String radioId) async {
    final stopwatch = Stopwatch()..start();

    final songFile = await generateSample(radioId: radioId);

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
    final sample = songFile.readAsBytesSync()..buffer.asUint8List();

    final fields = {
      'access_key': _options.accessKey,
      'data_type': _options.dataType,
      'signature_version': _options.signatureVersion,
      'signature': signature,
      'sample_bytes': sample.length.toString(),
      'timestamp': timestamp.toString(),
    };

    final uri = Uri(
      scheme: 'https',
      host: arcCloudHost,
      path: 'v1/identify',
    );

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(fields);
    request.files.add(http.MultipartFile.fromBytes('sample', sample));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final result = SongRecognitionResponse.fromJson(
      jsonDecode(response.body) as Map,
    );

    log('Done in ${stopwatch.elapsedMilliseconds}ms');
    final track = result.metadata?.music?.first;

    songFile.deleteSync();

    return track == null
        ? "Couldn't recognise the song :("
        : 'Song found: ${'${track.title} - ${track.artists?.first.name}'}';
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
