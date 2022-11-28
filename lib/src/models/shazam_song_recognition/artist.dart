import 'package:freezed_annotation/freezed_annotation.dart';

part 'artist.freezed.dart';
part 'artist.g.dart';

@freezed
class ShazamArtist with _$ShazamArtist {
  factory ShazamArtist({
    String? adamid,
    String? id,
  }) = _ShazamArtist;

  factory ShazamArtist.fromJson(Map<String, dynamic> json) =>
      _$ShazamArtistFromJson(json);
}
