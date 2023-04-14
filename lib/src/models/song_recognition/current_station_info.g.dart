// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_station_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentStationInfo _$CurrentStationInfoFromJson(Map<String, dynamic> json) =>
    CurrentStationInfo(
      contentType: json['content-type'] as String?,
      description: json['description'] as String?,
      genre: json['genre'] as String?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$CurrentStationInfoToJson(CurrentStationInfo instance) =>
    <String, dynamic>{
      'description': instance.description,
      'content-type': instance.contentType,
      'genre': instance.genre,
      'name': instance.name,
      'title': instance.title,
      'url': instance.url,
      'image': instance.image,
    };
