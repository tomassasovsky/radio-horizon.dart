import 'package:json_annotation/json_annotation.dart';

part 'share.g.dart';

@JsonSerializable()
class ShazamShare {
  const ShazamShare({
    this.avatar,
    this.href,
    this.html,
    this.image,
    this.snapchat,
    this.subject,
    this.text,
    this.twitter,
  });

  factory ShazamShare.fromJson(Map<String, dynamic> json) =>
      _$ShazamShareFromJson(json);

  final String? avatar;
  final String? href;
  final String? html;
  final String? image;
  final String? snapchat;
  final String? subject;
  final String? text;
  final String? twitter;
}
