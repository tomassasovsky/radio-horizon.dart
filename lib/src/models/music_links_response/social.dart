import 'package:freezed_annotation/freezed_annotation.dart';

part 'social.freezed.dart';
part 'social.g.dart';

@freezed
class MusicLinksSocial with _$MusicLinksSocial {
  const factory MusicLinksSocial({
    String? name,
    String? url,
  }) = _MusicLinksSocial;

  factory MusicLinksSocial.fromJson(Map<String, dynamic> json) =>
      _$MusicLinksSocialFromJson(json);
}
