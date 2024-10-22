// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:radio_horizon/radio_horizon.dart';

final administratorCheck = UserCheck.anyId(
  adminIds,
  name: 'Administrator check',
);

final botConnectedToAVoiceChannelCheck = Check(
  (CommandContext context) async {
    final guildId = context.guild?.id;
    if (guildId == null) {
      return false;
    }

    final botVoiceState = context.guild?.voiceStates[context.client.user.id];
    return botVoiceState?.channel != null;
  },
  name: 'musicConnectedToVC',
);

final botNotConnectedToAVoiceChannelCheck = Check(
  (CommandContext context) async {
    final guildId = context.guild?.id;
    if (guildId == null) {
      return false;
    }

    final botVoiceState = context.guild?.voiceStates[context.client.user.id];

    return botVoiceState?.channel == null;
  },
  name: 'musicNotConnectedToVC',
);

final userConnectedToVoiceChannelCheck = Check(
  (CommandContext context) async {
    final userVoiceState = context.guild?.voiceStates[context.member?.id];
    return userVoiceState != null || userVoiceState?.channel != null;
  },
  name: 'musicUserConnectedToVC',
);

final sameVoiceChannelOrDisconnectedCheck = Check(
  (CommandContext context) async {
    final userVoiceState = context.guild?.voiceStates[context.member?.id];
    final botVoiceState = context.guild?.voiceStates[context.client.user.id];

    if (botVoiceState?.channel == null) {
      return true;
    }

    return userVoiceState?.channel == botVoiceState?.channel;
  },
  name: 'musicSameVC',
);
