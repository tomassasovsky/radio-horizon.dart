// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShazamProvider _$ShazamProviderFromJson(Map<String, dynamic> json) =>
    ShazamProvider(
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => ShazamAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      caption: json['caption'] as String?,
      images: json['images'] == null
          ? null
          : ShazamImages.fromJson(json['images'] as Map<String, dynamic>),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ShazamProviderToJson(ShazamProvider instance) =>
    <String, dynamic>{
      'actions': instance.actions,
      'caption': instance.caption,
      'images': instance.images,
      'type': instance.type,
    };
