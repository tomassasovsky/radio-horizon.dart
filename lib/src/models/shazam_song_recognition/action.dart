import 'package:json_annotation/json_annotation.dart';

part 'action.g.dart';

@JsonSerializable()
class ShazamAction {
  const ShazamAction({
    this.id,
    this.name,
    this.type,
    this.uri,
  });

  factory ShazamAction.fromJson(Map<String, dynamic> json) =>
      _$ShazamActionFromJson(json);

  final String? id;
  final String? name;
  final String? type;
  final String? uri;
}
