import 'package:json_annotation/json_annotation.dart';
import 'package:radio_garden/radio_garden.dart';

part 'section.g.dart';

@JsonSerializable()
class ShazamSection {
  const ShazamSection({
    this.metadata,
    this.metapages,
    this.tabname,
    this.type,
    this.beacondata,
    this.footer,
    this.text,
    this.url,
    this.youtubeurl,
  });

  factory ShazamSection.fromJson(Map<String, dynamic> json) =>
      _$ShazamSectionFromJson(json);

  final List<ShazamMetadatum>? metadata;
  final List<ShazamMetapage>? metapages;
  final String? tabname;
  final String? type;
  final ShazamBeacondata? beacondata;
  final String? footer;
  final List<String>? text;
  final String? url;
  final String? youtubeurl;
}
