// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShazamShare _$ShazamShareFromJson(Map<String, dynamic> json) => ShazamShare(
      avatar: json['avatar'] as String?,
      href: json['href'] as String?,
      html: json['html'] as String?,
      image: json['image'] as String?,
      snapchat: json['snapchat'] as String?,
      subject: json['subject'] as String?,
      text: json['text'] as String?,
      twitter: json['twitter'] as String?,
    );

Map<String, dynamic> _$ShazamShareToJson(ShazamShare instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'href': instance.href,
      'html': instance.html,
      'image': instance.image,
      'snapchat': instance.snapchat,
      'subject': instance.subject,
      'text': instance.text,
      'twitter': instance.twitter,
    };
