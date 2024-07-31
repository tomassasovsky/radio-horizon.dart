import 'dart:convert';

class Urlparams {
  Urlparams({
    this.trackartist,
    this.tracktitle,
  });

  factory Urlparams.fromRawJson(String str) =>
      Urlparams.fromJson(json.decode(str) as Map);

  factory Urlparams.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Urlparams(
      trackartist: json['{trackartist}'] as String?,
      tracktitle: json['{tracktitle}'] as String?,
    );
  }
  final String? trackartist;
  final String? tracktitle;

  Urlparams copyWith({
    String? trackartist,
    String? tracktitle,
  }) =>
      Urlparams(
        trackartist: trackartist ?? this.trackartist,
        tracktitle: tracktitle ?? this.tracktitle,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        '{trackartist}': trackartist,
        '{tracktitle}': tracktitle,
      };
}
