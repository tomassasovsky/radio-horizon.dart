import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class ShazamArtist {
  const ShazamArtist({
    this.adamid,
    this.id,
  });

  factory ShazamArtist.fromJson(Map<String, dynamic> json) =>
      _$ShazamArtistFromJson(json);

  final String? adamid;
  final String? id;
}
