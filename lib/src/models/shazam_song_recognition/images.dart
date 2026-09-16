import 'package:json_annotation/json_annotation.dart';

part 'images.g.dart';

@JsonSerializable()
class ShazamImages {
  const ShazamImages({
    this.imagesDefault,
    this.overflow,
  });

  factory ShazamImages.fromJson(Map<String, dynamic> json) =>
      _$ShazamImagesFromJson(json);

  @JsonKey(name: 'default')
  final String? imagesDefault;

  final String? overflow;
}
