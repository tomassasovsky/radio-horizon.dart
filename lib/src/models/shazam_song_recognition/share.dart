import 'package:freezed_annotation/freezed_annotation.dart';

part 'share.freezed.dart';
part 'share.g.dart';

@freezed
class ShazamShare with _$ShazamShare {
  factory ShazamShare({
    String? avatar,
    String? href,
    String? html,
    String? image,
    String? snapchat,
    String? subject,
    String? text,
    String? twitter,
  }) = _ShazamShare;

  factory ShazamShare.fromJson(Map<String, dynamic> json) =>
      _$ShazamShareFromJson(json);
}
