import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nyxx/nyxx.dart';
import 'package:radio_garden/radio_garden.dart';

part 'shazam_result.freezed.dart';
part 'shazam_result.g.dart';

@freezed
class ShazamResult with _$ShazamResult {
  const factory ShazamResult({
    String? albumadamid,
    List<ShazamArtist>? artists,
    ShazamGenres? genres,
    ShazamHighlightsurls? highlightsurls,
    ShazamHub? hub,
    ShazamImages? images,
    String? isrc,
    String? key,
    String? layout,
    String? relatedtracksurl,
    List<ShazamSection>? sections,
    ShazamShare? share,
    String? subtitle,
    String? title,
    String? type,
    String? url,
    Urlparams? urlparams,
    List<String>? lyrics,
  }) = _ShazamResult;

  const ShazamResult._();

  factory ShazamResult.fromJson(Map<String, dynamic> json) =>
      _$ShazamResultFromJson(json);

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
