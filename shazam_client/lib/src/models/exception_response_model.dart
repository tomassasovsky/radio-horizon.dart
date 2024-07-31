import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

/// {@template exception_response}
/// A class that represents the error response from the backend.
/// {@endtemplate}
class ExceptionResponse with EquatableMixin implements Exception {
  /// {@macro exception_response}
  const ExceptionResponse({
    this.error,
    this.statusCode,
    this.path,
  });

  /// Creates an [ExceptionResponse] from a JSON object.
  factory ExceptionResponse.fromJson(Map<String, dynamic> json) {
    return ExceptionResponse(
      error: json['error'] as String?,
      statusCode: json['statusCode'] as int? ?? 500,
      path: json['path'] as String?,
    );
  }

  /// Checks if the response is a JSON error response.
  static bool matches(http.Response response) {
    if (response.statusCode != 200) {
      try {
        jsonDecode(response.body);
        return true;
      } catch (_) {
        // If decoding fails, it might not be a JSON response.
        return false;
      }
    }
    return false;
  }

  /// Merges the [ExceptionResponse] with the [http.Response].
  final String? error;

  /// The status code of the response.
  final int? statusCode;

  /// The path of the request that caused the error.
  final String? path;

  @override
  String toString() =>
      'ExceptionResponse(error: $error, statusCode: $statusCode, path: $path)';
  @override
  List<Object?> get props => [error, statusCode, path];
}
