// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'urlparams.g.dart';

@JsonSerializable()
class Urlparams {
  const Urlparams({
    this.trackartist,
    this.tracktitle,
  });

  factory Urlparams.fromJson(Map<String, dynamic> json) =>
      _$UrlparamsFromJson(json);

  @JsonKey(name: '{trackartist}')
  final String? trackartist;

  @JsonKey(name: '{tracktitle}')
  final String? tracktitle;
}
