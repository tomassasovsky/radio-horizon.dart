// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:collection/collection.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:radio_horizon/src/models/exceptions.dart';

export 'info.dart';
export 'music.dart';
export 'radio.dart';
export 'sound.dart';

Future<LavalinkPlayer?> connectLavalink(CommandContext context) async {
  final voiceState = context.guild?.voiceStates[context.member?.id];
  if (voiceState == null || voiceState.channel == null) {
    throw const UserNotConnectedToVoiceChannelException();
  }

  final voiceChannel = (await voiceState.channel!.fetch()) as VoiceChannel;
  final player = await voiceChannel.connectLavalink();
  return player;
}

Future<LavalinkPlayer?> connectToChannel(
  Guild guild,
  Snowflake channelId, {
  bool replace = false,
}) async {
  final voiceChannels = await guild.fetchChannels();
  final voiceChannel = voiceChannels
      .firstWhereOrNull((element) => element.id == channelId) as VoiceChannel?;
  if (voiceChannel == null) {
    return null;
  }

  return voiceChannel.connectLavalink();
}

TranslationsCommandsEn getCommandTranslations(InteractionChatContext context) {
  final userLocale = context.interaction.locale ??
      context.guild?.preferredLocale ??
      Locale.enUs;
  final commandTranslations =
      AppLocaleUtils.parse(userLocale.identifier).translations.commands;

  return commandTranslations;
}

TranslationsCommandsEn getCommandTranslationsForGuild(Guild guild) {
  final userLocale = guild.preferredLocale;
  final commandTranslations =
      AppLocaleUtils.parse(userLocale.identifier).translations.commands;

  return commandTranslations;
}

TranslationsCommandsEn getLocale(InteractionChatContext context) {
  final userLocale = context.interaction.locale ??
      context.guild?.preferredLocale ??
      Locale.enUs;
  final commandTranslations =
      AppLocaleUtils.parse(userLocale.identifier).translations.commands;

  return commandTranslations;
}
