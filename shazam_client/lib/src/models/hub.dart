
import 'dart:convert';

import 'package:shazam_client/shazam_client.dart';

class Hub {
  Hub({
    this.actions,
    this.displayname,
    this.explicit,
    this.image,
    this.options,
    this.providers,
    this.type,
  });

  factory Hub.fromRawJson(String str) => Hub.fromJson(json.decode(str) as Map);

  factory Hub.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Hub(
      actions: json['actions'] == null
          ? null
          : List<Action>.from(
              (json['actions'] as List)
                  .cast<Map<dynamic, dynamic>>()
                  .map(Action.fromJson),
            ),
      displayname: json['displayname'] as String?,
      explicit: json['explicit'] as bool?,
      image: json['image'] as String?,
      options: json['options'] == null
          ? null
          : List<Option>.from(
              (json['options'] as List)
                  .cast<Map<dynamic, dynamic>>()
                  .map(Option.fromJson),
            ),
      providers: json['providers'] == null
          ? null
          : List<Provider>.from(
              (json['providers'] as List)
                  .cast<Map<dynamic, dynamic>>()
                  .map(Provider.fromJson),
            ),
      type: json['type'] as String?,
    );
  }
  final List<Action>? actions;
  final String? displayname;
  final bool? explicit;
  final String? image;
  final List<Option>? options;
  final List<Provider>? providers;
  final String? type;

  Hub copyWith({
    List<Action>? actions,
    String? displayname,
    bool? explicit,
    String? image,
    List<Option>? options,
    List<Provider>? providers,
    String? type,
  }) =>
      Hub(
        actions: actions ?? this.actions,
        displayname: displayname ?? this.displayname,
        explicit: explicit ?? this.explicit,
        image: image ?? this.image,
        options: options ?? this.options,
        providers: providers ?? this.providers,
        type: type ?? this.type,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'actions': actions == null
            ? null
            : List<dynamic>.from(actions!.map((x) => x.toJson())),
        'displayname': displayname,
        'explicit': explicit,
        'image': image,
        'options': options == null
            ? null
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        'providers': providers == null
            ? null
            : List<dynamic>.from(providers!.map((x) => x.toJson())),
        'type': type,
      };
}
