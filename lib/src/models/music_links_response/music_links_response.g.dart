// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_links_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicLinksResponse _$MusicLinksResponseFromJson(Map<String, dynamic> json) =>
    MusicLinksResponse(
      id: json['id'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      links: json['links'] == null
          ? []
          : MusicLinksPlatform.listFromJson(
              json['links'] as Map<String, dynamic>),
      times: json['times'] as num?,
    );
