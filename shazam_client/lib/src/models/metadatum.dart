import 'dart:convert';

class Metadatum {
  Metadatum({
    this.text,
    this.title,
  });

  factory Metadatum.fromRawJson(String str) =>
      Metadatum.fromJson(json.decode(str) as Map);

  factory Metadatum.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Metadatum(
      text: json['text'] as String?,
      title: json['title'] as String?,
    );
  }
  final String? text;
  final String? title;

  Metadatum copyWith({
    String? text,
    String? title,
  }) =>
      Metadatum(
        text: text ?? this.text,
        title: title ?? this.title,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'text': text,
        'title': title,
      };
}
