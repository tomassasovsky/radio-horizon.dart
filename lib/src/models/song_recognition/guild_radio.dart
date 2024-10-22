// Copyright (c) 2022, Jorge Rincón Arias
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:nyxx/nyxx.dart';
import 'package:radio_browser_api/radio_browser_api.dart';

class GuildRadio {
  const GuildRadio(
    this.guildId, {
    required this.station,
    required this.voiceChannelId,
    required this.textChannelId,
  });

  factory GuildRadio.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();
    return GuildRadio(
      Snowflake.parse(json['guildId'].toString()),
      station: Station.fromJson((json['station'] as Map).cast()),
      voiceChannelId: Snowflake.parse(json['voiceChannelId'].toString()),
      textChannelId: Snowflake.parse(json['textChannelId'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        'guildId': guildId.toString(),
        'station': station.toJson(),
        'voiceChannelId': voiceChannelId.toString(),
        'textChannelId': textChannelId.toString(),
      };

  final Snowflake guildId;
  final Snowflake voiceChannelId;
  final Snowflake textChannelId;
  final Station station;
}
