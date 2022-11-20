// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:radio_garden/radio_garden.dart';

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

class SongRecognitionOptions {
  SongRecognitionOptions({
    required this.accessKey,
    required this.accessSecret,
    required this.host,
    this.endpoint = '/v1/identify',
    this.signatureVersion = '1',
    this.dataType = 'audio',
    this.secure = true,
  }) : assert(
          dataType == 'audio' || dataType == 'fingerprint',
          'dataType must be audio or fingerprint',
        );

  final String host;
  final String endpoint;
  final String signatureVersion;
  final String dataType;
  final bool secure;
  final String accessKey;
  final String accessSecret;
}

Future<SongRecognitionResponse> identify(
  Uint8List data,
  SongRecognitionOptions options,
) async {
  final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  final stringToSign = buildStringToSign(
    'POST',
    options.endpoint,
    options.accessKey,
    options.dataType,
    options.signatureVersion,
    timestamp.toString(),
  );

  final signature = sign(stringToSign, options.accessSecret);
  final sample = data.buffer.asUint8List();

  final fields = {
    'access_key': options.accessKey,
    'data_type': options.dataType,
    'signature_version': options.signatureVersion,
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
  return SongRecognitionResponse.fromJson(
    jsonDecode(response.body) as Map,
  );
}

Future<void> main(List<String> args) async {
  dotEnvFlavour = DotEnvFlavour.development;
  dotEnvFlavour.initialize();

  final stopwatch = Stopwatch()..start();
  log('Recognising song...');

  final fileContents = File('sample.mp3').readAsBytesSync();
  final result = await identify(
    fileContents,
    SongRecognitionOptions(
      accessKey: arcCloudAccessKey,
      accessSecret: arcCloudAccessSecret,
      host: arcCloudHost,
    ),
  );

  log('Done in ${stopwatch.elapsedMilliseconds}ms');
  final track = result.metadata?.music?.first;
  log(
    track == null
        ? 'No song found'
        : 'Song found: ${'${track.title} - ${track.artists?.first.name}'}',
  );
}
