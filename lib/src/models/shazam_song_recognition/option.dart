import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:radio_garden/radio_garden.dart';

part 'option.freezed.dart';
part 'option.g.dart';

@freezed
class ShazamOption with _$ShazamOption {
  factory ShazamOption({
    List<ShazamAction>? actions,
    ShazamBeacondata? beacondata,
    String? caption,
    bool? colouroverflowimage,
    String? image,
    String? listcaption,
    String? overflowimage,
    String? providername,
    String? type,
  }) = _ShazamOption;

  factory ShazamOption.fromJson(Map<String, dynamic> json) =>
      _$ShazamOptionFromJson(json);
}
