import 'dart:convert';

class Share {
  Share({
    this.avatar,
    this.href,
    this.html,
    this.image,
    this.snapchat,
    this.subject,
    this.text,
    this.twitter,
  });

  factory Share.fromRawJson(String str) =>
      Share.fromJson(json.decode(str) as Map);

  factory Share.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Share(
      avatar: json['avatar'] as String?,
      href: json['href'] as String?,
      html: json['html'] as String?,
      image: json['image'] as String?,
      snapchat: json['snapchat'] as String?,
      subject: json['subject'] as String?,
      text: json['text'] as String?,
      twitter: json['twitter'] as String?,
    );
  }

  final String? avatar;
  final String? href;
  final String? html;
  final String? image;
  final String? snapchat;
  final String? subject;
  final String? text;
  final String? twitter;

  Share copyWith({
    String? avatar,
    String? href,
    String? html,
    String? image,
    String? snapchat,
    String? subject,
    String? text,
    String? twitter,
  }) =>
      Share(
        avatar: avatar ?? this.avatar,
        href: href ?? this.href,
        html: html ?? this.html,
        image: image ?? this.image,
        snapchat: snapchat ?? this.snapchat,
        subject: subject ?? this.subject,
        text: text ?? this.text,
        twitter: twitter ?? this.twitter,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'href': href,
        'html': html,
        'image': image,
        'snapchat': snapchat,
        'subject': subject,
        'text': text,
        'twitter': twitter,
      };
}
