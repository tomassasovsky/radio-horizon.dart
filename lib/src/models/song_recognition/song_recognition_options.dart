// Copyright (c) 2022, Jorge Rincón Arias
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

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
