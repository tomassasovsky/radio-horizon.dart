import 'dart:convert';

import 'package:shazam_client/shazam_client.dart';

class Provider {
  Provider({
    this.actions,
    this.caption,
    this.images,
    this.type,
  });

  factory Provider.fromRawJson(String str) =>
      Provider.fromJson(json.decode(str) as Map);

  factory Provider.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Provider(
      actions: json['actions'] == null
          ? null
          : List<Action>.from(
              (json['actions'] as List)
                  .cast<Map<dynamic, dynamic>>()
                  .map(Action.fromJson),
            ),
      caption: json['caption'] as String?,
      images: json['images'] == null
          ? null
          : ProviderImages.fromJson(json['images'] as Map),
      type: json['type'] as String?,
    );
  }
  final List<Action>? actions;
  final String? caption;
  final ProviderImages? images;
  final String? type;

  Provider copyWith({
    List<Action>? actions,
    String? caption,
    ProviderImages? images,
    String? type,
  }) =>
      Provider(
        actions: actions ?? this.actions,
        caption: caption ?? this.caption,
        images: images ?? this.images,
        type: type ?? this.type,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'actions': actions == null
            ? null
            : List<dynamic>.from(actions!.map((x) => x.toJson())),
        'caption': caption,
        'images': images?.toJson(),
        'type': type,
      };
}
