import 'package:json_annotation/json_annotation.dart';

part 'metadatum.g.dart';

@JsonSerializable()
class ShazamMetadatum {
  const ShazamMetadatum({
    this.text,
    this.title,
  });

  factory ShazamMetadatum.fromJson(Map<String, dynamic> json) =>
      _$ShazamMetadatumFromJson(json);

  final String? text;
  final String? title;
}
