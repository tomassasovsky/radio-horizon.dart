// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shazam_song_recognition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShazamSongRecognition _$ShazamSongRecognitionFromJson(
        Map<String, dynamic> json) =>
    ShazamSongRecognition(
      ok: json['ok'] as bool?,
      result: json['result'] == null
          ? null
          : ShazamResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShazamSongRecognitionToJson(
        ShazamSongRecognition instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'result': instance.result,
    };
