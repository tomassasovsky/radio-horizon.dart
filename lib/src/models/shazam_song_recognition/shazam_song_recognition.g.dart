// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shazam_song_recognition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ShazamSongRecognition _$$_ShazamSongRecognitionFromJson(
        Map<String, dynamic> json) =>
    _$_ShazamSongRecognition(
      ok: json['ok'] as bool?,
      result: json['result'] == null
          ? null
          : ShazamResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ShazamSongRecognitionToJson(
        _$_ShazamSongRecognition instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'result': instance.result,
    };
