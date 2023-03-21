import 'package:json_annotation/json_annotation.dart';
import 'package:nyxx/nyxx.dart';
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

  List<List<String>>? paragraphedLyrics(int paragraphsPerPage) {
    if (lyrics == null || lyrics!.isEmpty) return null;
    final llyrics = lyrics ?? [];
    final paragraphs = llyrics.join('\n').split('\n\n');

    final m = (paragraphs.length / paragraphsPerPage).round();
    final lists = List.generate(
      3,
      (i) => paragraphs.sublist(
        m * i,
        (i + 1) * m <= paragraphs.length ? (i + 1) * m : null,
      ),
    );

    return lists;
  }

  List<EmbedBuilder>? lyricsPages({
    required DiscordColor color,
  }) {
    final lyricsPages = <EmbedBuilder>[];
    final llyrics = paragraphedLyrics(3);

    if (llyrics == null) return null;

    // add 3 paragraphs per page
    for (var i = 0; i < llyrics.length; i++) {
      final embed = EmbedBuilder()
        ..color = color
        ..title = title
        ..description = llyrics[i].join('\n\n');

      lyricsPages.add(embed);
    }

    return lyricsPages;
  }
}
