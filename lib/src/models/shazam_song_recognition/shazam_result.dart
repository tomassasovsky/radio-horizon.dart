import 'package:json_annotation/json_annotation.dart';
import 'package:radio_horizon/radio_horizon.dart';

part 'shazam_result.g.dart';

@JsonSerializable()
class ShazamResult {
  const ShazamResult({
    this.albumadamid,
    this.artists,
    this.genres,
    this.highlightsurls,
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
    this.lyrics,
  });

  factory ShazamResult.fromJson(Map<String, dynamic> json) =>
      _$ShazamResultFromJson(json);

  final String? albumadamid;
  final List<ShazamArtist>? artists;
  final ShazamGenres? genres;
  final ShazamHighlightsurls? highlightsurls;
  final ShazamHub? hub;
  final ShazamImages? images;
  final String? isrc;
  final String? key;
  final String? layout;
  final String? relatedtracksurl;
  final List<ShazamSection>? sections;
  final ShazamShare? share;
  final String? subtitle;
  final String? title;
  final String? type;
  final String? url;
  final Urlparams? urlparams;
  final List<String>? lyrics;

  String get headline => '$title - $subtitle';
}
