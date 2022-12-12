// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:radio_garden/radio_garden.dart';

final administratorCheck =
    UserCheck.anyId(adminIds, name: 'Administrator check');

final connectedToAVoiceChannelCheck = Check(
  (ICommandContextData context) async {
    final selfMember = await context.guild!.selfMember.getOrDownload();

    if (selfMember.voiceState == null ||
        selfMember.voiceState!.channel == null) {
      return false;
    }
    return true;
  },
  name: 'musicConnectedToVC',
);

final notConnectedToAVoiceChannelCheck = Check(
  (ICommandContextData context) async {
    final selfMember = await context.guild!.selfMember.getOrDownload();

    if (selfMember.voiceState == null ||
        selfMember.voiceState!.channel == null) {
      return true;
    }
    return false;
  },
  name: 'musicNotConnectedToVC',
);

final userConnectedToVoiceChannelCheck = Check(
  (ICommandContextData context) {
    final memberVoiceState = context.member!.voiceState;

    if (memberVoiceState == null || memberVoiceState.channel == null) {
      return false;
    }
    return true;
  },
  name: 'musicUserConnectedToVC',
);

final sameVoiceChannelOrDisconnectedCheck = Check(
  (ICommandContextData context) async {
    // If this is an interaction, acknowledge it just in case the check
    // takes too long to run.
    if (context is InteractionChatContext) {
      await context.acknowledge();
    }

    final selfMemberVoiceState =
        (await context.guild!.selfMember.getOrDownload()).voiceState;
    // The upper check should be executed before, so its okay to
    // assume the voice state exists.
    final memberVoiceState = context.member!.voiceState!;

    if (selfMemberVoiceState == null || selfMemberVoiceState.channel == null) {
      return true;
    }

    if (selfMemberVoiceState.channel!.id != memberVoiceState.channel!.id) {
      return false;
    }
    return true;
  },
  name: 'musicSameVC',
);
