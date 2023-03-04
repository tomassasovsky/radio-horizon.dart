import 'package:json_annotation/json_annotation.dart';

part 'platform.g.dart';

@JsonSerializable()
class MusicLinksPlatform {
  const MusicLinksPlatform({
    this.name,
    this.url,
  });

  factory MusicLinksPlatform.fromJson(Map<String, dynamic> json) =>
      _$MusicLinksPlatformFromJson(json);

  final String? name;
  final String? url;
}
