// Copyright (c) 2022, Jorge Rincón Arias
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:nyxx/nyxx.dart';
import 'package:radio_browser_api/radio_browser_api.dart';

class GuildRadio {
  const GuildRadio(
    this.id, {
    required this.station,
  });

  factory GuildRadio.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();
    return GuildRadio(
      Snowflake(json['guildId'] as String),
      station: Station.fromJson(json.cast()),
    );
  }

  final Snowflake id;
  final Station station;
}
