import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:radio_garden/radio_garden.dart';

part 'hub.freezed.dart';
part 'hub.g.dart';

@freezed
class ShazamHub with _$ShazamHub {
  factory ShazamHub({
    List<ShazamAction>? actions,
    String? displayname,
    bool? explicit,
    String? image,
    List<ShazamOption>? options,
    List<ShazamProvider>? providers,
    String? type,
  }) = _ShazamHub;

  factory ShazamHub.fromJson(Map<String, dynamic> json) =>
      _$ShazamHubFromJson(json);
}
