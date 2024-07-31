import 'dart:convert';

import 'package:shazam_client/shazam_client.dart';

class SongModel {
  SongModel({
    this.albumadamid,
    this.artists,
    this.genres,
    this.hub,
    this.images,
    this.isrc,
    this.key,
    this.layout,
    this.relatedtracksurl,
    this.sections,
    this.share,
    this.subtitle,
    this.title,
    this.type,
    this.url,
    this.urlparams,
  });

  factory SongModel.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return SongModel(
      albumadamid: json['albumadamid'] as String?,
      artists: json['artists'] == null
          ? null
          : List<Artist>.from(
              (json['artists'] as List)
                  .cast<Map<dynamic, dynamic>>()
                  .map(Artist.fromJson),
            ),
      genres: json['genres'] == null
          ? null
          : Genres.fromJson(json['genres'] as Map),
      hub: json['hub'] == null ? null : Hub.fromJson(json['hub'] as Map),
      images: json['images'] == null
          ? null
          : SongModelImages.fromJson(json['images'] as Map),
      isrc: json['isrc'] as String?,
      key: json['key'] as String?,
      layout: json['layout'] as String?,
      relatedtracksurl: json['relatedtracksurl'] as String?,
      sections: json['sections'] == null
          ? null
          : List<Section>.from(
              (json['sections'] as List)
                  .cast<Map<dynamic, dynamic>>()
                  .map(Section.fromJson),
            ),
      share:
          json['share'] == null ? null : Share.fromJson(json['share'] as Map),
      subtitle: json['subtitle'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
      urlparams: json['urlparams'] == null
          ? null
          : Urlparams.fromJson(json['urlparams'] as Map),
    );
  }

  factory SongModel.fromRawJson(String str) =>
      SongModel.fromJson(json.decode(str) as Map);

  final String? albumadamid;
  final List<Artist>? artists;
  final Genres? genres;
  final Hub? hub;
  final SongModelImages? images;
  final String? isrc;
  final String? key;
  final String? layout;
  final String? relatedtracksurl;
  final List<Section>? sections;
  final Share? share;
  final String? subtitle;
  final String? title;
  final String? type;
  final String? url;
  final Urlparams? urlparams;

  SongModel copyWith({
    String? albumadamid,
    List<Artist>? artists,
    Genres? genres,
    Hub? hub,
    SongModelImages? images,
    String? isrc,
    String? key,
    String? layout,
    String? relatedtracksurl,
    List<Section>? sections,
    Share? share,
    String? subtitle,
    String? title,
    String? type,
    String? url,
    Urlparams? urlparams,
  }) =>
      SongModel(
        albumadamid: albumadamid ?? this.albumadamid,
        artists: artists ?? this.artists,
        genres: genres ?? this.genres,
        hub: hub ?? this.hub,
        images: images ?? this.images,
        isrc: isrc ?? this.isrc,
        key: key ?? this.key,
        layout: layout ?? this.layout,
        relatedtracksurl: relatedtracksurl ?? this.relatedtracksurl,
        sections: sections ?? this.sections,
        share: share ?? this.share,
        subtitle: subtitle ?? this.subtitle,
        title: title ?? this.title,
        type: type ?? this.type,
        url: url ?? this.url,
        urlparams: urlparams ?? this.urlparams,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'albumadamid': albumadamid,
        'artists': artists == null
            ? null
            : List<dynamic>.from(artists!.map((x) => x.toJson())),
        'genres': genres?.toJson(),
        'hub': hub?.toJson(),
        'images': images?.toJson(),
        'isrc': isrc,
        'key': key,
        'layout': layout,
        'relatedtracksurl': relatedtracksurl,
        'sections': sections == null
            ? null
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
        'share': share?.toJson(),
        'subtitle': subtitle,
        'title': title,
        'type': type,
        'url': url,
        'urlparams': urlparams?.toJson(),
      };
}
