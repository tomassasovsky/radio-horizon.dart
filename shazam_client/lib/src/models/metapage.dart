import 'dart:convert';

class Metapage {
  Metapage({
    this.caption,
    this.image,
  });

  factory Metapage.fromRawJson(String str) =>
      Metapage.fromJson(json.decode(str) as Map);

  factory Metapage.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Metapage(
      caption: json['caption'] as String?,
      image: json['image'] as String?,
    );
  }
  final String? caption;
  final String? image;

  Metapage copyWith({
    String? caption,
    String? image,
  }) =>
      Metapage(
        caption: caption ?? this.caption,
        image: image ?? this.image,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'caption': caption,
        'image': image,
      };
}
