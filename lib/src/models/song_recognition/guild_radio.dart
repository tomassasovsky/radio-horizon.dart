import 'package:radio_garden/radio_garden.dart';

class GuildRadio {
  const GuildRadio({
    required this.guildId,
    required this.radio,
  });

  factory GuildRadio.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();
    return GuildRadio(
      guildId: json['guildId'] as String,
      radio: RadioGardenSearchResponse.fromJson(json),
    );
  }

  final String guildId;
  final RadioGardenSearchResponse radio;
}
