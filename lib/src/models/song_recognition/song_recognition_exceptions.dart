class SongRecognitionException implements Exception {
  const SongRecognitionException();
}

/// Throws when there is no RadioGardenSearchResponse associated with the
/// SongRecognitionService
class RadioNotPlayingException extends SongRecognitionException {
  const RadioNotPlayingException();
}

/// Throws when there's an issue with the http.Client
class RadioCantCommunicateWithServer extends SongRecognitionException {
  const RadioCantCommunicateWithServer(this.error);

  final Exception? error;
}
