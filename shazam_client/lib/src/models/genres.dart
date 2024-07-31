import 'dart:convert';

class Genres {
  Genres({
    this.primary,
    this.secondary,
  });

  factory Genres.fromRawJson(String str) =>
      Genres.fromJson(json.decode(str) as Map);

  factory Genres.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Genres(
      primary: json['primary'] as String?,
      secondary: json['secondary'] as String?,
    );
  }
  final String? primary;
  final String? secondary;

  Genres copyWith({
    String? primary,
    String? secondary,
  }) =>
      Genres(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'primary': primary,
        'secondary': secondary,
      };
}
