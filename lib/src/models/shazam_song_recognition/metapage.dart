import 'package:freezed_annotation/freezed_annotation.dart';

part 'metapage.freezed.dart';
part 'metapage.g.dart';

@freezed
class ShazamMetapage with _$ShazamMetapage {
  factory ShazamMetapage({
    String? caption,
    String? image,
  }) = _ShazamMetapage;

  factory ShazamMetapage.fromJson(Map<String, dynamic> json) =>
      _$ShazamMetapageFromJson(json);
}
