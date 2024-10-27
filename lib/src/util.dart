// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';
import 'dart:math';
import 'package:nyxx/nyxx.dart';
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

Map<String, String> queuedTrackToAnalyticsParameters(Track track) {
  return {
    'identifier': track.info.identifier,
    'isSeekable': track.info.isSeekable.toString(),
    'author': track.info.author,
    'length': track.info.length.toString(),
    'isStream': track.info.isStream.toString(),
    'position': track.info.position.toString(),
    'title': track.info.title,
    'uri': track.info.uri.toString(),
    'artworkUrl': track.info.artworkUrl.toString(),
    'isrc': track.info.isrc.toString(),
    'sourceName': track.info.sourceName,
  };
}

Map<Locale, String> localizedValues(
  String Function(Translations translations) getter,
) {
  final locales = AppLocaleUtils.instance.locales;
  final translations = <Locale, String>{};

  for (final locale in locales) {
    final key = Locale.values.firstWhere(
      (element) => element.identifier.startsWith(locale.languageTag),
      orElse: () => Locale.enUs,
    );

    final result = getter(locale.translations);
    translations[key] = result;
  }

  return translations;
}

String getDartPlatform() => Platform.version.split('(').first;
