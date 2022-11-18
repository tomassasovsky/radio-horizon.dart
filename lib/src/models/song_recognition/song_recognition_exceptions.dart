// Copyright (c) 2022, Jorge Rincón Arias
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

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

/// Throws when there's an issue  identifying the song, it is related to
/// the http.Client
class RadioCantIdentifySongException extends SongRecognitionException {
  const RadioCantIdentifySongException();
}
