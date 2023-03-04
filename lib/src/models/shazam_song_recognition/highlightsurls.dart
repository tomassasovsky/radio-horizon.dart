import 'package:json_annotation/json_annotation.dart';

part 'highlightsurls.g.dart';

@JsonSerializable()
class ShazamHighlightsurls {
  const ShazamHighlightsurls({
    this.artisthighlightsurl,
    this.trackhighlighturl,
  });

  factory ShazamHighlightsurls.fromJson(Map<String, dynamic> json) =>
      _$ShazamHighlightsurlsFromJson(json);

  final String? artisthighlightsurl;
  final String? trackhighlighturl;
}
