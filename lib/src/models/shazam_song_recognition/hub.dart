import 'package:json_annotation/json_annotation.dart';
import 'package:radio_horizon/radio_horizon.dart';

part 'hub.g.dart';

@JsonSerializable()
class ShazamHub {
  const ShazamHub({
    this.actions,
    this.displayname,
    this.explicit,
    this.image,
    this.options,
    this.providers,
    this.type,
  });

  factory ShazamHub.fromJson(Map<String, dynamic> json) =>
      _$ShazamHubFromJson(json);

  final List<ShazamAction>? actions;
  final String? displayname;
  final bool? explicit;
  final String? image;
  final List<ShazamOption>? options;
  final List<ShazamProvider>? providers;
  final String? type;
}
