/// Thrown if an exception occurs while making an http request.
class HttpException implements Exception {}

/// {@template http_request_failure}
/// Thrown if an http request returns a non-200 status code.
/// {@endtemplate}
class HttpRequestFailure implements Exception {
  /// {@macro http_request_failure}
  const HttpRequestFailure(this.statusCode, this.error);

  /// The status code of the response.
  final int statusCode;

  /// The error message of the response.
  final String error;

  @override
  String toString() =>
      'HttpRequestFailure(statusCode: $statusCode, error: $error)';
}

/// Thrown when an error occurs while decoding the response body.
class JsonDecodeException implements Exception {
  /// Thrown when an error occurs while decoding the response body.
  const JsonDecodeException();
}

/// Thrown when an error occurs while decoding the response body.
class SpecifiedTypeNotMatchedException implements Exception {
  /// Thrown when an error occurs while decoding the response body.
  const SpecifiedTypeNotMatchedException();
}

/// Thrown when an unknown error occurs.
class UnknownException implements Exception {
  /// Thrown when an unknown error occurs.
  const UnknownException();
}

/// This exception is thrown if the server sends a request with an unexpected
/// status code or missing/invalid headers.
class ProtocolException implements Exception {
  /// Create a new ProtocolException.
  ProtocolException(
    this.message, [
    this.code,
  ]);

  /// Message from the exception
  final String message;

  /// Code from the exception.
  final int? code;

  /// Returns a string representation of this exception.
  @override
  String toString() => 'ProtocolException: ($code) $message';
}
