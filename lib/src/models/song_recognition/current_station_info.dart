import 'package:json_annotation/json_annotation.dart';
import 'package:nyxx/nyxx.dart';
import 'package:radio_horizon/radio_horizon.dart';

part 'current_station_info.g.dart';

@JsonSerializable()
class CurrentStationInfo {
  const CurrentStationInfo({
    this.description,
    this.genre,
    this.name,
    this.title,
    this.image,
    this.url,
  }) : _lyrics = null;

  const CurrentStationInfo._lyrics({
    this.description,
    this.genre,
    this.name,
    this.title,
    this.image,
    this.url,
    List<String>? lyrics,
  }) : _lyrics = lyrics;

  factory CurrentStationInfo.fromJson(Map<String, dynamic> json) =>
      _$CurrentStationInfoFromJson(json);

  factory CurrentStationInfo.fromShazamResult(
    ShazamResult result,
    GuildRadio radio,
  ) =>
      CurrentStationInfo._lyrics(
        name: result.headline,
        title: radio.station.name,
        description: result.subtitle,
        url: radio.station.urlResolved ?? radio.station.url,
        image: result.share?.image ?? radio.station.favicon,
        genre: result.genres?.primary,
        lyrics: result.lyrics,
      );

  CurrentStationInfo copyWith({
    String? description,
    String? genre,
    String? name,
    String? title,
    String? image,
    String? url,
    List<String>? lyrics,
  }) =>
      CurrentStationInfo._lyrics(
        lyrics: lyrics ?? _lyrics,
        description: description ?? this.description,
        genre: genre ?? this.genre,
        name: name ?? this.name,
        title: title ?? this.title,
        image: image ?? this.image,
        url: url ?? this.url,
      );

  final String? description;
  final String? genre;
  final String? name;
  final String? title;
  final String? image;
  final String? url;
  final List<String>? _lyrics;

  bool get hasName => name != null && name!.isNotEmpty;
  bool get hasTitle => title != null && title!.isNotEmpty;

  List<List<String>>? paragraphedLyrics(int paragraphsPerPage) {
    if (_lyrics == null || _lyrics!.isEmpty) return null;
    final lyrics = _lyrics ?? [];
    final paragraphs = lyrics.join('\n').split('\n\n');

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