// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'images.freezed.dart';
part 'images.g.dart';

@freezed
class ShazamImages with _$ShazamImages {
  factory ShazamImages({
    @JsonKey(name: 'default') String? imagesDefault,
    String? overflow,
  }) = _ShazamImages;

  factory ShazamImages.fromJson(Map<String, dynamic> json) =>
      _$ShazamImagesFromJson(json);
}
