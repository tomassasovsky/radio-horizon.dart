import 'dart:convert';

class SongModelImages {
  SongModelImages({
    this.background,
    this.coverart,
    this.coverarthq,
    this.joecolor,
  });

  factory SongModelImages.fromRawJson(String str) =>
      SongModelImages.fromJson(json.decode(str) as Map);

  factory SongModelImages.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return SongModelImages(
      background: json['background'] as String?,
      coverart: json['coverart'] as String?,
      coverarthq: json['coverarthq'] as String?,
      joecolor: json['joecolor'] as String?,
    );
  }
  final String? background;
  final String? coverart;
  final String? coverarthq;
  final String? joecolor;

  SongModelImages copyWith({
    String? background,
    String? coverart,
    String? coverarthq,
    String? joecolor,
  }) =>
      SongModelImages(
        background: background ?? this.background,
        coverart: coverart ?? this.coverart,
        coverarthq: coverarthq ?? this.coverarthq,
        joecolor: joecolor ?? this.joecolor,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'background': background,
        'coverart': coverart,
        'coverarthq': coverarthq,
        'joecolor': joecolor,
      };
}
