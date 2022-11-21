// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ShazamOption _$$_ShazamOptionFromJson(Map<String, dynamic> json) =>
    _$_ShazamOption(
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => ShazamAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      beacondata: json['beacondata'] == null
          ? null
          : ShazamBeacondata.fromJson(
              json['beacondata'] as Map<String, dynamic>),
      caption: json['caption'] as String?,
      colouroverflowimage: json['colouroverflowimage'] as bool?,
      image: json['image'] as String?,
      listcaption: json['listcaption'] as String?,
      overflowimage: json['overflowimage'] as String?,
      providername: json['providername'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$_ShazamOptionToJson(_$_ShazamOption instance) =>
    <String, dynamic>{
      'actions': instance.actions,
      'beacondata': instance.beacondata,
      'caption': instance.caption,
      'colouroverflowimage': instance.colouroverflowimage,
      'image': instance.image,
      'listcaption': instance.listcaption,
      'overflowimage': instance.overflowimage,
      'providername': instance.providername,
      'type': instance.type,
    };
