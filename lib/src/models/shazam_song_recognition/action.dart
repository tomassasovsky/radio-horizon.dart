import 'package:freezed_annotation/freezed_annotation.dart';

part 'action.freezed.dart';
part 'action.g.dart';

@freezed
class ShazamAction with _$ShazamAction {
  factory ShazamAction({
    String? id,
    String? name,
    String? type,
    String? uri,
  }) = _ShazamAction;

  factory ShazamAction.fromJson(Map<String, dynamic> json) =>
      _$ShazamActionFromJson(json);
}
