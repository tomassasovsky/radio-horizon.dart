import 'dart:convert';

import 'package:shazam_client/shazam_client.dart';

class Option {
  Option({
    this.actions,
    this.beacondata,
    this.caption,
    this.colouroverflowimage,
    this.image,
    this.listcaption,
    this.overflowimage,
    this.providername,
    this.type,
  });

  factory Option.fromRawJson(String str) =>
      Option.fromJson(json.decode(str) as Map);

  factory Option.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Option(
      actions: json['actions'] == null
          ? null
          : List<Action>.from(
              (json['actions'] as List)
                  .cast<Map<dynamic, dynamic>>()
                  .map(Action.fromJson),
            ),
      beacondata: json['beacondata'] == null
          ? null
          : Beacondata.fromJson(json['beacondata'] as Map),
      caption: json['caption'] as String?,
      colouroverflowimage: json['colouroverflowimage'] as bool?,
      image: json['image'] as String?,
      listcaption: json['listcaption'] as String?,
      overflowimage: json['overflowimage'] as String?,
      providername: json['providername'] as String?,
      type: json['type'] as String?,
    );
  }
  final List<Action>? actions;
  final Beacondata? beacondata;
  final String? caption;
  final bool? colouroverflowimage;
  final String? image;
  final String? listcaption;
  final String? overflowimage;
  final String? providername;
  final String? type;

  Option copyWith({
    List<Action>? actions,
    Beacondata? beacondata,
    String? caption,
    bool? colouroverflowimage,
    String? image,
    String? listcaption,
    String? overflowimage,
    String? providername,
    String? type,
  }) =>
      Option(
        actions: actions ?? this.actions,
        beacondata: beacondata ?? this.beacondata,
        caption: caption ?? this.caption,
        colouroverflowimage: colouroverflowimage ?? this.colouroverflowimage,
        image: image ?? this.image,
        listcaption: listcaption ?? this.listcaption,
        overflowimage: overflowimage ?? this.overflowimage,
        providername: providername ?? this.providername,
        type: type ?? this.type,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'actions': actions == null
            ? null
            : List<dynamic>.from(actions!.map((x) => x.toJson())),
        'beacondata': beacondata?.toJson(),
        'caption': caption,
        'colouroverflowimage': colouroverflowimage,
        'image': image,
        'listcaption': listcaption,
        'overflowimage': overflowimage,
        'providername': providername,
        'type': type,
      };
}
