import 'package:json_annotation/json_annotation.dart';
import 'package:radio_horizon/radio_horizon.dart';

part 'option.g.dart';

@JsonSerializable()
class ShazamOption {
  const ShazamOption({
    this.actions,
    this.beacondata,
    this.caption,
    this.colouroverflowimage,
    this.image,
    this.listcaption,
    this.overflowimage,
    this.providername,
    this.type,
  });

  factory ShazamOption.fromJson(Map<String, dynamic> json) =>
      _$ShazamOptionFromJson(json);

  final List<ShazamAction>? actions;
  final ShazamBeacondata? beacondata;
  final String? caption;
  final bool? colouroverflowimage;
  final String? image;
  final String? listcaption;
  final String? overflowimage;
  final String? providername;
  final String? type;
}
