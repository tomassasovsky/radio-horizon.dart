import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:radio_garden/radio_garden.dart';

part 'section.freezed.dart';
part 'section.g.dart';

@freezed
class ShazamSection with _$ShazamSection {
  factory ShazamSection({
    List<ShazamMetadatum>? metadata,
    List<ShazamMetapage>? metapages,
    String? tabname,
    String? type,
    ShazamBeacondata? beacondata,
    String? footer,
    List<String>? text,
    String? url,
    String? youtubeurl,
  }) = _ShazamSection;

  factory ShazamSection.fromJson(Map<String, dynamic> json) =>
      _$ShazamSectionFromJson(json);
}
