import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shazam_client/shazam_client.dart';

/// ShazamApiClientBase is the base class for all API Requests available.
@internal
abstract class ShazamApiClientBase {
  ShazamApiClientBase({
    required this.timeout,
  });

  /// The timeout for all API requests.
  /// Only exposed for testing purposes. Do not use directly.
  @visibleForTesting
  final Duration timeout;

  /// The host URL used for all API requests.
  ///
  /// Only exposed for testing purposes. Do not use directly.
  @visibleForTesting
  String get authority;

  /// The port to which the API requests are made.
  /// Only exposed for testing purposes. Do not use directly.
  /// Defaults to 5000.
  @visibleForTesting
  int get port => 5000;

  /// The http client used for all API requests.
  ///
  /// Only exposed for testing purposes. Do not use directly.
  @visibleForTesting
  final http.Client httpClient = http.Client();

  Future<T> post<T>(
    Uri uri, {
    Object? body,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    bool needsToken = true,
  }) async {
    assert(
      body is Map || body is List || body == null,
      'Invalid body type. Only Map, List or null are allowed. '
      'Got: ${body.runtimeType}',
    );

    http.Response response;

    try {
      response = await httpClient.post(
        uri,
        body: (body != null) ? jsonEncode(body) : null,
        headers: {
          if (needsToken) ...headersAlways,
          'needs-token': '$needsToken',
          ...?headers,
        },
      );
    } on SocketException {
      rethrow;
    } on TimeoutException {
      rethrow;
    } catch (_) {
      throw HttpException();
    }

    return _handleResponse<T>(response);
  }

  Future<T> patch<T>(
    Uri uri, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    bool needsToken = true,
  }) async {
    http.Response response;

    try {
      response = await httpClient.patch(
        uri,
        body: (body != null) ? jsonEncode(body) : null,
        headers: {
          if (needsToken) ...headersAlways,
          'needs-token': '$needsToken',
          ...?headers,
        },
      );
    } on SocketException {
      rethrow;
    } on TimeoutException {
      rethrow;
    } catch (_) {
      throw HttpException();
    }

    return _handleResponse<T>(response);
  }

  Future<T> get<T>(
    Uri uri, {
    bool needsToken = true,
    Map<String, String>? headers,
  }) async {
    http.Response response;

    try {
      response = await httpClient.get(
        uri,
        headers: {
          if (needsToken) ...headersAlways,
          'needs-token': '$needsToken',
          ...?headers,
        },
      );
    } on SocketException {
      rethrow;
    } on TimeoutException {
      rethrow;
    } catch (_) {
      throw HttpException();
    }

    return _handleResponse<T>(response);
  }

  Future<T> put<T>(
    Uri uri, {
    Map<String, dynamic>? body,
    bool needsToken = true,
    Map<String, String>? headers,
  }) async {
    http.Response response;

    try {
      response = await httpClient.put(
        uri,
        body: (body != null) ? jsonEncode(body) : null,
        headers: {
          if (needsToken) ...headersAlways,
          'needs-token': '$needsToken',
          ...?headers,
        },
      );
    } on SocketException {
      rethrow;
    } on TimeoutException {
      rethrow;
    } catch (_) {
      throw HttpException();
    }

    return _handleResponse<T>(response);
  }

  Future<T> delete<T>(
    Uri uri, {
    Map<String, dynamic>? body,
    bool needsToken = true,
    Map<String, String>? headers,
  }) async {
    http.Response response;

    try {
      response = await httpClient.delete(
        uri,
        body: (body != null) ? jsonEncode(body) : null,
        headers: {
          if (needsToken) ...headersAlways,
          'needs-token': '$needsToken',
          ...?headers,
        },
      );
    } on SocketException {
      rethrow;
    } on TimeoutException {
      rethrow;
    } catch (_) {
      throw HttpException();
    }

    return _handleResponse<T>(response);
  }

  T _handleResponse<T>(http.Response response) {
    try {
      if (response is T) return response as T;

      final dynamic decodedResponse = jsonDecode(response.body);

      if (response.isFailure && decodedResponse is Map<String, dynamic>) {
        if (ExceptionResponse.matches(response)) {
          throw ExceptionResponse.fromJson(decodedResponse);
        }

        throw HttpRequestFailure(
          response.statusCode,
          response.reasonPhrase ?? '',
        );
      }

      if (decodedResponse is T) return decodedResponse;

      try {
        if (T == JSON) {
          (decodedResponse as Map).cast<String, dynamic>() as T;
        } else if (T == JSONLIST) {
          final newResponse = (decodedResponse as List)
              .map<JSON>(
                (dynamic item) => (item as Map).cast<String, dynamic>(),
              )
              .toList();
          return newResponse as T;
        }

        return decodedResponse as T;
      } catch (_) {
        throw const SpecifiedTypeNotMatchedException();
      }
    } on FormatException {
      throw const JsonDecodeException();
    }
  }

  /// Closes the http_interceptor client.
  void close() {
    httpClient.close();
  }

  @internal
  Map<String, String> get headersAlways => <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json',
      };
}

/// A class to make it easier to handle the response from the API.
extension Result on http.Response {
  /// Returns true if the response is a success.
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// Returns true if the response is a failure.
  bool get isFailure => !isSuccess;
}
