import 'package:json_annotation/json_annotation.dart';

part 'beacondata.g.dart';

@JsonSerializable()
class ShazamBeacondata {
  const ShazamBeacondata({
    this.providername,
    this.type,
  });

  factory ShazamBeacondata.fromJson(Map<String, dynamic> json) =>
      _$ShazamBeacondataFromJson(json);

  final String? providername;
  final String? type;
}
