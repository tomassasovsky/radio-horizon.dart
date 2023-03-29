import 'package:json_annotation/json_annotation.dart';
import 'package:radio_horizon/radio_horizon.dart';

export 'action.dart';
export 'artist.dart';
export 'beacondata.dart';
export 'genres.dart';
export 'highlightsurls.dart';
export 'hub.dart';
export 'images.dart';
export 'metadatum.dart';
export 'metapage.dart';
export 'option.dart';
export 'provider.dart';
export 'section.dart';
export 'share.dart';
export 'shazam_result.dart';
export 'shazam_song_recognition.dart';
export 'urlparams.dart';

part 'shazam_song_recognition.g.dart';

@JsonSerializable()
class ShazamSongRecognition {
  const ShazamSongRecognition({
    this.ok,
    this.result,
  });

  factory ShazamSongRecognition.fromJson(Map<String, dynamic> json) =>
      _$ShazamSongRecognitionFromJson(json);

  final bool? ok;
  final ShazamResult? result;
}
