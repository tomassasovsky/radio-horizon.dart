import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shazam_client/shazam_client.dart';
import 'package:shazam_client/src/shazam_client_base.dart';

/// {@template shazam_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ShazamClient extends ShazamApiClientBase {
  /// {@macro shazam_client}
  ShazamClient.localhost({
    super.timeout = const Duration(seconds: 10),
  })  : _baseUrl = 'localhost',
        _port = 5000;

  /// {@macro shazam_client}
  ShazamClient.dockerized({
    super.timeout = const Duration(seconds: 10),
  })  : _baseUrl = 'shazam_api',
        _port = 5000;

  final String _baseUrl;
  final int _port;

  @override
  String get authority => _baseUrl;

  @override
  int get port => _port;

  /// Recognizes a song from a given [song].
  Future<SongModel> recognizeSong(File song) async {
    final uri = Uri(
      scheme: 'http',
      host: authority,
      port: port,
      path: '/recognize',
    );

    try {
      final request = http.MultipartRequest('GET', uri)
        ..files.add(
          http.MultipartFile(
            'file',
            song.readAsBytes().asStream(),
            song.lengthSync(),
            filename: song.path.split('/').last,
          ),
        );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.isFailure) {
        throw HttpException();
      }

      return SongModel.fromJson(
        (jsonDecode(response.body) as Map).cast(),
      );
    } on SocketException {
      rethrow;
    } on TimeoutException {
      rethrow;
    } catch (e) {
      throw HttpException();
    }
  }
}
