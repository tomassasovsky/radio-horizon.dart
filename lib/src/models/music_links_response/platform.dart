import 'package:freezed_annotation/freezed_annotation.dart';

part 'platform.freezed.dart';
part 'platform.g.dart';

@freezed
class MusicLinksPlatform with _$MusicLinksPlatform {
  const factory MusicLinksPlatform({
    String? name,
    String? url,
  }) = _MusicLinksPlatform;

  factory MusicLinksPlatform.fromJson(Map<String, dynamic> json) =>
      _$MusicLinksPlatformFromJson(json);
}
