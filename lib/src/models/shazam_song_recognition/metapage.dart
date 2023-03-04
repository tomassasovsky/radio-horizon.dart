import 'package:json_annotation/json_annotation.dart';

part 'metapage.g.dart';

@JsonSerializable()
class ShazamMetapage {
  const ShazamMetapage({
    this.caption,
    this.image,
  });

  factory ShazamMetapage.fromJson(Map<String, dynamic> json) =>
      _$ShazamMetapageFromJson(json);

  final String? caption;
  final String? image;
}
