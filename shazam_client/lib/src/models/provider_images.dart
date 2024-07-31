import 'dart:convert';

class ProviderImages {
  ProviderImages({
    this.imagesDefault,
    this.overflow,
  });

  factory ProviderImages.fromRawJson(String str) =>
      ProviderImages.fromJson(json.decode(str) as Map);

  factory ProviderImages.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return ProviderImages(
      imagesDefault: json['default'] as String?,
      overflow: json['overflow'] as String?,
    );
  }
  final String? imagesDefault;
  final String? overflow;

  ProviderImages copyWith({
    String? imagesDefault,
    String? overflow,
  }) =>
      ProviderImages(
        imagesDefault: imagesDefault ?? this.imagesDefault,
        overflow: overflow ?? this.overflow,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'default': imagesDefault,
        'overflow': overflow,
      };
}
