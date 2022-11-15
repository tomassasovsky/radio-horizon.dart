// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:radio_garden/radio_garden.dart';

export 'info.dart';
export 'music.dart';
export 'radio.dart';

Future<void> connectIfNeeded(
  IChatContext context, {
  bool replace = false,
}) async {
  if (replace) {
    MusicService.instance.cluster
        .getOrCreatePlayerNode(context.guild!.id)
        .destroy(context.guild!.id);
    context.guild!.shard.changeVoiceState(context.guild!.id, null);
  }

  await Future<void>.delayed(const Duration(milliseconds: 500));

  final selfMember = await context.guild!.selfMember.getOrDownload();

  if ((selfMember.voiceState == null ||
          selfMember.voiceState?.channel == null) &&
      (context.member?.voiceState != null &&
          context.member?.voiceState?.channel != null)) {
    context.guild!.shard.changeVoiceState(
      context.guild!.id,
      context.member!.voiceState!.channel!.id,
    );
  }
}
