import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:radio_garden/radio_garden.dart';

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

part 'shazam_song_recognition.freezed.dart';
part 'shazam_song_recognition.g.dart';

@freezed
class ShazamSongRecognition with _$ShazamSongRecognition {
  factory ShazamSongRecognition({
    bool? ok,
    ShazamResult? result,
  }) = _ShazamSongRecognition;

  factory ShazamSongRecognition.fromJson(Map<String, dynamic> json) =>
      _$ShazamSongRecognitionFromJson(json);
}
