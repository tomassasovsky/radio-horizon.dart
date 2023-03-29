import 'package:json_annotation/json_annotation.dart';

part 'genres.g.dart';

@JsonSerializable()
class ShazamGenres {
  const ShazamGenres({
    this.primary,
  });

  factory ShazamGenres.fromJson(Map<String, dynamic> json) =>
      _$ShazamGenresFromJson(json);

  final String? primary;
}
