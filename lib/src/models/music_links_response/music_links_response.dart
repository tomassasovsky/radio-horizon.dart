import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_garden/radio_garden.dart';

export 'platform.dart';
export 'social.dart';

part 'music_links_response.freezed.dart';
part 'music_links_response.g.dart';

MusicLinksResponse musicLinksResponseFromJson(String str) =>
    MusicLinksResponse.fromJson(json.decode(str) as Map);

@freezed
class MusicLinksResponse with _$MusicLinksResponse {
  const factory MusicLinksResponse({
    String? image,
    String? name,
    List<MusicLinksPlatform>? platforms,
    List<MusicLinksSocial>? social,
  }) = _MusicLinksResponse;

  const MusicLinksResponse._();

  factory MusicLinksResponse.fromJson(Map<dynamic, dynamic> json) =>
      _$MusicLinksResponseFromJson(json.cast());

  factory MusicLinksResponse.empty() => const MusicLinksResponse();

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
