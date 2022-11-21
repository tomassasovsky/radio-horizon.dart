// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'urlparams.freezed.dart';
part 'urlparams.g.dart';

@freezed
class Urlparams with _$Urlparams {
  factory Urlparams({
    @JsonKey(name: '{trackartist}') String? trackartist,
    @JsonKey(name: '{tracktitle}') String? tracktitle,
  }) = _Urlparams;

  factory Urlparams.fromJson(Map<String, dynamic> json) =>
      _$UrlparamsFromJson(json);
}
