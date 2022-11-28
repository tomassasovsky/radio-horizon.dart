// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ShazamSection _$$_ShazamSectionFromJson(Map<String, dynamic> json) =>
    _$_ShazamSection(
      metadata: (json['metadata'] as List<dynamic>?)
          ?.map((e) => ShazamMetadatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      metapages: (json['metapages'] as List<dynamic>?)
          ?.map((e) => ShazamMetapage.fromJson(e as Map<String, dynamic>))
          .toList(),
      tabname: json['tabname'] as String?,
      type: json['type'] as String?,
      beacondata: json['beacondata'] == null
          ? null
          : ShazamBeacondata.fromJson(
              json['beacondata'] as Map<String, dynamic>),
      footer: json['footer'] as String?,
      text: (json['text'] as List<dynamic>?)?.map((e) => e as String).toList(),
      url: json['url'] as String?,
      youtubeurl: json['youtubeurl'] as String?,
    );

Map<String, dynamic> _$$_ShazamSectionToJson(_$_ShazamSection instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'metapages': instance.metapages,
      'tabname': instance.tabname,
      'type': instance.type,
      'beacondata': instance.beacondata,
      'footer': instance.footer,
      'text': instance.text,
      'url': instance.url,
      'youtubeurl': instance.youtubeurl,
    };
