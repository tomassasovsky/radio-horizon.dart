// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShazamAction _$ShazamActionFromJson(Map<String, dynamic> json) => ShazamAction(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      uri: json['uri'] as String?,
    );

Map<String, dynamic> _$ShazamActionToJson(ShazamAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'uri': instance.uri,
    };
