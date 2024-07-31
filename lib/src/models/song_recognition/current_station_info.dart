import 'package:json_annotation/json_annotation.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:shazam_client/shazam_client.dart';

part 'current_station_info.g.dart';

@JsonSerializable()
class CurrentStationInfo {
  const CurrentStationInfo({
    this.contentType,
    this.description,
    this.genre,
    this.name,
    this.title,
    this.image,
    this.url,
  });

  factory CurrentStationInfo.fromJson(Map<String, dynamic> json) =>
      _$CurrentStationInfoFromJson(json);

  factory CurrentStationInfo.fromShazamResult(
    SongModel result, [
    GuildRadio? guildRadio,
  ]) =>
      CurrentStationInfo(
        title: '${result.title} - ${result.subtitle}',
        description: result.subtitle,
        url: Uri.https(
          'youtube.com',
          '/results',
          {'search_query': result.title},
        ).toString(),
        image: result.images?.coverart,
        genre: result.genres?.primary,
        name: guildRadio?.station.name,
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
      CurrentStationInfo(
        description: description ?? this.description,
        genre: genre ?? this.genre,
        name: name ?? this.name,
        title: title ?? this.title,
        image: image ?? this.image,
        url: url ?? this.url,
      );

  /// Station description
  final String? description;

  /// MIME type
  @JsonKey(name: 'content-type')
  final String? contentType;

  /// Genre of the radio
  final String? genre;

  /// Station name
  final String? name;

  /// Now playing information
  final String? title;

  /// Url to the radio
  final String? url;

  final String? image;

  bool get hasName => name != null && name!.isNotEmpty;
  bool get hasTitle => title != null && title!.isNotEmpty;
}
