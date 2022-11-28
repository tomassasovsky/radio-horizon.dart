import 'package:freezed_annotation/freezed_annotation.dart';

part 'highlightsurls.freezed.dart';
part 'highlightsurls.g.dart';

@freezed
class ShazamHighlightsurls with _$ShazamHighlightsurls {
  factory ShazamHighlightsurls({
    String? artisthighlightsurl,
    String? trackhighlighturl,
  }) = _ShazamHighlightsurls;

  factory ShazamHighlightsurls.fromJson(Map<String, dynamic> json) =>
      _$ShazamHighlightsurlsFromJson(json);
}
