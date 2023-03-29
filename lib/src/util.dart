// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:math';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_horizon/radio_horizon.dart';

DiscordColor getRandomColor() {
  final random = Random();

  return DiscordColor.fromRgb(
    random.nextInt(255),
    random.nextInt(255),
    random.nextInt(255),
  );
}

Map<String, String> queuedTrackToAnalyticsParameters(IQueuedTrack track) {
  return {
    'channel_id': track.channelId?.id.toString() ?? 'null',
    'track_uri': track.track.info?.uri ?? 'null',
    'track_title': track.track.info?.title ?? 'null',
    'track_author': track.track.info?.author ?? 'null',
    'track_identifier': track.track.info?.identifier ?? 'null',
    'track_duration': track.track.info?.length.toString() ?? 'null',
    'track_position': track.track.info?.position.toString() ?? 'null',
    'track_is_stream': track.track.info?.stream.toString() ?? 'null',
    'track_is_seekable': track.track.info?.seekable.toString() ?? 'null',
    'track_base64': track.track.track,
  };
}

Map<Locale, String> localizedValues(
  String Function(StringsEn translations) getter,
) {
  final locales = AppLocaleUtils.instance.locales;
  final translations = <Locale, String>{};

  for (final locale in locales) {
    final key = Locale.values.firstWhere(
      (element) => element.code.startsWith(locale.languageTag),
      orElse: () => Locale.englishUs,
    );

    final result = getter(locale.translations);
    translations[key] = result;
  }

  return translations;
}
