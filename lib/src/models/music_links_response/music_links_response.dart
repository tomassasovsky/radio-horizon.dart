import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:radio_horizon/radio_horizon.dart';

export 'platform.dart';

part 'music_links_response.g.dart';

MusicLinksResponse musicLinksResponseFromJson(String str) =>
    MusicLinksResponse.fromJson(json.decode(str) as Map);

@JsonSerializable(createToJson: false)
class MusicLinksResponse {
  const MusicLinksResponse({
    this.id,
    this.title,
    this.image,
    this.links,
    this.times,
  });

  factory MusicLinksResponse.fromJson(Map<dynamic, dynamic> json) =>
      _$MusicLinksResponseFromJson((json['obj'] as Map).cast());

  factory MusicLinksResponse.empty() => const MusicLinksResponse();

  final String? id;
  final String? image;
  final String? title;
  @JsonKey(
    defaultValue: <MusicLinksPlatform>[],
    fromJson: MusicLinksPlatform.listFromJson,
  )
  final List<MusicLinksPlatform>? links;
  final num? times;

  Set<MusicLinksPlatform> get uniquePlatforms {
    if (links == null) return {};

    // check all platforms have unique names
    final localPlatforms = <MusicLinksPlatform>{};
    for (final platform in links!) {
      if (localPlatforms.any((element) => element.name == platform.name)) {
        continue;
      }

      localPlatforms.add(platform);
    }

    return localPlatforms;
  }
}
