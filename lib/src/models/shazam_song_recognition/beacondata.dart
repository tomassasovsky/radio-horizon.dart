import 'package:freezed_annotation/freezed_annotation.dart';

part 'beacondata.freezed.dart';
part 'beacondata.g.dart';

@freezed
class ShazamBeacondata with _$ShazamBeacondata {
  factory ShazamBeacondata({
    String? providername,
    String? type,
  }) = _ShazamBeacondata;

  factory ShazamBeacondata.fromJson(Map<String, dynamic> json) =>
      _$ShazamBeacondataFromJson(json);
}
