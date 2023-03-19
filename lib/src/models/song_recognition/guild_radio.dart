// Copyright (c) 2022, Jorge Rincón Arias
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:radio_browser_api/radio_browser_api.dart';

class GuildRadio {
  const GuildRadio({
    required this.guildId,
    required this.radio,
  });

  factory GuildRadio.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();
    return GuildRadio(
      guildId: json['guildId'] as String,
      radio: Station.fromJson(json.cast()),
    );
  }

  final String guildId;
  final Station radio;
}
