// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shazam_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShazamResult _$ShazamResultFromJson(Map<String, dynamic> json) => ShazamResult(
      albumadamid: json['albumadamid'] as String?,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => ShazamArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: json['genres'] == null
          ? null
          : ShazamGenres.fromJson(json['genres'] as Map<String, dynamic>),
      highlightsurls: json['highlightsurls'] == null
          ? null
          : ShazamHighlightsurls.fromJson(
              json['highlightsurls'] as Map<String, dynamic>),
      hub: json['hub'] == null
          ? null
          : ShazamHub.fromJson(json['hub'] as Map<String, dynamic>),
      images: json['images'] == null
          ? null
          : ShazamImages.fromJson(json['images'] as Map<String, dynamic>),
      isrc: json['isrc'] as String?,
      key: json['key'] as String?,
      layout: json['layout'] as String?,
      relatedtracksurl: json['relatedtracksurl'] as String?,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => ShazamSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      share: json['share'] == null
          ? null
          : ShazamShare.fromJson(json['share'] as Map<String, dynamic>),
      subtitle: json['subtitle'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
      urlparams: json['urlparams'] == null
          ? null
          : Urlparams.fromJson(json['urlparams'] as Map<String, dynamic>),
      lyrics:
          (json['lyrics'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ShazamResultToJson(ShazamResult instance) =>
    <String, dynamic>{
      'albumadamid': instance.albumadamid,
      'artists': instance.artists,
      'genres': instance.genres,
      'highlightsurls': instance.highlightsurls,
      'hub': instance.hub,
      'images': instance.images,
      'isrc': instance.isrc,
      'key': instance.key,
      'layout': instance.layout,
      'relatedtracksurl': instance.relatedtracksurl,
      'sections': instance.sections,
      'share': instance.share,
      'subtitle': instance.subtitle,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url,
      'urlparams': instance.urlparams,
      'lyrics': instance.lyrics,
    };
