import 'package:json_annotation/json_annotation.dart';

part 'social.g.dart';

@JsonSerializable()
class MusicLinksSocial {
  const MusicLinksSocial({
    this.name,
    this.url,
  });

  factory MusicLinksSocial.fromJson(Map<String, dynamic> json) =>
      _$MusicLinksSocialFromJson(json);

  final String? name;
  final String? url;
}
