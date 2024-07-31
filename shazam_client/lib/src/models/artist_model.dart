import 'dart:convert';

class Artist {
  Artist({
    this.adamid,
    this.id,
  });

  factory Artist.fromRawJson(String str) =>
      Artist.fromJson(json.decode(str) as Map);

  factory Artist.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Artist(
      adamid: json['adamid'] as String?,
      id: json['id'] as String?,
    );
  }
  final String? adamid;
  final String? id;

  Artist copyWith({
    String? adamid,
    String? id,
  }) =>
      Artist(
        adamid: adamid ?? this.adamid,
        id: id ?? this.id,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'adamid': adamid,
        'id': id,
      };
}
