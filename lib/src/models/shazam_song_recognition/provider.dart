import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:radio_garden/radio_garden.dart';

part 'provider.freezed.dart';
part 'provider.g.dart';

@freezed
class ShazamProvider with _$ShazamProvider {
  factory ShazamProvider({
    List<ShazamAction>? actions,
    String? caption,
    ShazamImages? images,
    String? type,
  }) = _ShazamProvider;

  factory ShazamProvider.fromJson(Map<String, dynamic> json) =>
      _$ShazamProviderFromJson(json);
}
