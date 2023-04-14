import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
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

  List<ComponentRowBuilder> get componentRows {
    var addedLinks = 0;
    final buttonRowBuilders = <ComponentRowBuilder>[];

    void addLinkButton(MusicLinksPlatform? platform) {
      if (platform == null) return;

      final url = platform.url;
      final label = platform.name;

      if (url == null || label == null) return;

      // the buttons in a button row can't be more than 5
      if (addedLinks % 5 == 0) {
        buttonRowBuilders.add(ComponentRowBuilder());
      }

      final button = LinkButtonBuilder(label, url);
      buttonRowBuilders.last.addComponent(button);
      addedLinks++;
    }

    for (final element in uniquePlatforms) {
      addLinkButton(element);
    }

    if (addedLinks == 0) return [];
    return buttonRowBuilders;
  }
}
