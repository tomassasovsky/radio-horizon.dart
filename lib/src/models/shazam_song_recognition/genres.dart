import 'package:freezed_annotation/freezed_annotation.dart';

part 'genres.freezed.dart';
part 'genres.g.dart';

@freezed
class ShazamGenres with _$ShazamGenres {
  factory ShazamGenres({
    String? primary,
  }) = _ShazamGenres;

  factory ShazamGenres.fromJson(Map<String, dynamic> json) =>
      _$ShazamGenresFromJson(json);
}
