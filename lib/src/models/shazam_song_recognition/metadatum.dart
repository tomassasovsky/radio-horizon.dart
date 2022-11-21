import 'package:freezed_annotation/freezed_annotation.dart';

part 'metadatum.freezed.dart';
part 'metadatum.g.dart';

@freezed
class ShazamMetadatum with _$ShazamMetadatum {
  factory ShazamMetadatum({
    String? text,
    String? title,
  }) = _ShazamMetadatum;

  factory ShazamMetadatum.fromJson(Map<String, dynamic> json) =>
      _$ShazamMetadatumFromJson(json);
}
