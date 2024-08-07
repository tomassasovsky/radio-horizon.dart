// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:get_it/get_it.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_horizon/radio_horizon.dart';

export 'info.dart';
export 'music.dart';
export 'radio.dart';
export 'sound.dart';

final _getIt = GetIt.instance;

Future<void> connectIfNeeded(
  IChatContext context, {
  bool replace = false,
}) async {
  if (replace) {
    _getIt
        .get<MusicService>()
        .cluster
        .getOrCreatePlayerNode(context.guild!.id)
        .destroy(context.guild!.id);
    context.guild!.shard.changeVoiceState(
      context.guild!.id,
      null,
      selfDeafen: true,
    );
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
      selfDeafen: true,
    );
  }
}

Future<void> connectToChannel(
  IGuild guild,
  Snowflake channelId, {
  bool replace = false,
}) async {
  if (replace) {
    _getIt
        .get<MusicService>()
        .cluster
        .getOrCreatePlayerNode(guild.id)
        .destroy(guild.id);
    guild.shard.changeVoiceState(
      guild.id,
      null,
      selfDeafen: true,
    );
  }

  final selfMember = await guild.selfMember.getOrDownload();

  if (selfMember.voiceState == null || selfMember.voiceState?.channel == null) {
    guild.shard.changeVoiceState(
      guild.id,
      channelId,
      selfDeafen: true,
    );
  }
}

StringsCommandsEn getCommandTranslations(InteractionChatContext context) {
  final userLocale = context.interaction.locale ??
      context.guild?.preferredLocale ??
      Locale.englishUs.code;
  final commandTranslations =
      AppLocaleUtils.parse(userLocale).translations.commands;

  return commandTranslations;
}

StringsCommandsEn getCommandTranslationsForGuild(IGuild guild) {
  final userLocale = guild.preferredLocale;
  final commandTranslations =
      AppLocaleUtils.parse(userLocale).translations.commands;

  return commandTranslations;
}

StringsCommandsEn getLocale(InteractionChatContext context) {
  final userLocale = context.interaction.locale ??
      context.guild?.preferredLocale ??
      Locale.englishUs.code;
  final commandTranslations =
      AppLocaleUtils.parse(userLocale).translations.commands;

  return commandTranslations;
}
