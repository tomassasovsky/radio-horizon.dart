import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_garden/radio_garden.dart';

export 'platform.dart';
export 'social.dart';

part 'music_links_response.g.dart';

MusicLinksResponse musicLinksResponseFromJson(String str) =>
    MusicLinksResponse.fromJson(json.decode(str) as Map);

@JsonSerializable()
class MusicLinksResponse {
  const MusicLinksResponse({
    this.image,
    this.name,
    this.platforms,
    this.social,
  });

  factory MusicLinksResponse.fromJson(Map<dynamic, dynamic> json) =>
      _$MusicLinksResponseFromJson(json.cast());

  factory MusicLinksResponse.empty() => const MusicLinksResponse();

  final String? image;
  final String? name;
  final List<MusicLinksPlatform>? platforms;
  final List<MusicLinksSocial>? social;

  Set<MusicLinksPlatform> get uniquePlatforms {
    if (platforms == null) return {};

    // check all platforms have unique names
    final localPlatforms = <MusicLinksPlatform>{};
    for (final platform in platforms!) {
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
