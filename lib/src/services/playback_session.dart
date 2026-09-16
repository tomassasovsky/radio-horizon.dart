// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:nyxx/nyxx.dart';
import 'package:radio_horizon/src/models/song_recognition/guild_radio.dart';

enum PlaybackSessionKind { idle, radio, music, lavalinkError }

class PlaybackSession {
  const PlaybackSession({
    required this.kind,
    this.stationName,
    this.trackTitle,
  });

  const PlaybackSession.idle() : this(kind: PlaybackSessionKind.idle);

  const PlaybackSession.lavalinkError()
      : this(kind: PlaybackSessionKind.lavalinkError);

  factory PlaybackSession.resolve({
    required Snowflake voiceChannelId,
    Snowflake? botChannelId,
    GuildRadio? radio,
    String? currentTrackTitle,
    bool lavalinkUnavailable = false,
  }) {
    if (lavalinkUnavailable) {
      return const PlaybackSession.lavalinkError();
    }

    if (botChannelId == null || botChannelId != voiceChannelId) {
      return const PlaybackSession.idle();
    }

    if (radio != null && radio.voiceChannelId == voiceChannelId) {
      return PlaybackSession(
        kind: PlaybackSessionKind.radio,
        stationName: radio.station.name,
      );
    }

    if (currentTrackTitle != null && currentTrackTitle.isNotEmpty) {
      return PlaybackSession(
        kind: PlaybackSessionKind.music,
        trackTitle: currentTrackTitle,
      );
    }

    return const PlaybackSession.idle();
  }

  final PlaybackSessionKind kind;
  final String? stationName;
  final String? trackTitle;
}
