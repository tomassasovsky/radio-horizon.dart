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
