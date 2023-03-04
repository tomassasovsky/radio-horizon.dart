// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_links_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicLinksResponse _$MusicLinksResponseFromJson(Map<String, dynamic> json) =>
    MusicLinksResponse(
      image: json['image'] as String?,
      name: json['name'] as String?,
      platforms: (json['platforms'] as List<dynamic>?)
          ?.map((e) => MusicLinksPlatform.fromJson(e as Map<String, dynamic>))
          .toList(),
      social: (json['social'] as List<dynamic>?)
          ?.map((e) => MusicLinksSocial.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MusicLinksResponseToJson(MusicLinksResponse instance) =>
    <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'platforms': instance.platforms,
      'social': instance.social,
    };
