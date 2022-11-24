// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ShazamHub _$$_ShazamHubFromJson(Map<String, dynamic> json) => _$_ShazamHub(
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => ShazamAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      displayname: json['displayname'] as String?,
      explicit: json['explicit'] as bool?,
      image: json['image'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => ShazamOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      providers: (json['providers'] as List<dynamic>?)
          ?.map((e) => ShazamProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$_ShazamHubToJson(_$_ShazamHub instance) =>
    <String, dynamic>{
      'actions': instance.actions,
      'displayname': instance.displayname,
      'explicit': instance.explicit,
      'image': instance.image,
      'options': instance.options,
      'providers': instance.providers,
      'type': instance.type,
    };
