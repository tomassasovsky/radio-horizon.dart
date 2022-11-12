// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:nyxx_commands/nyxx_commands.dart';

export 'info.dart';
export 'music.dart';
export 'radio.dart';

Future<void> connectIfNeeded(IChatContext context) async {
  final selfMember = await context.guild!.selfMember.getOrDownload();

  if ((selfMember.voiceState == null ||
          selfMember.voiceState!.channel == null) &&
      (context.member!.voiceState != null &&
          context.member!.voiceState!.channel != null)) {
    context.guild!.shard.changeVoiceState(
      context.guild!.id,
      context.member!.voiceState!.channel!.id,
    );
  }
}
