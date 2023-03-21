import 'package:json_annotation/json_annotation.dart';
import 'package:radio_horizon/radio_horizon.dart';

part 'provider.g.dart';

@JsonSerializable()
class ShazamProvider {
  const ShazamProvider({
    this.actions,
    this.caption,
    this.images,
    this.type,
  });

  factory ShazamProvider.fromJson(Map<String, dynamic> json) =>
      _$ShazamProviderFromJson(json);

  final List<ShazamAction>? actions;
  final String? caption;
  final ShazamImages? images;
  final String? type;
}
