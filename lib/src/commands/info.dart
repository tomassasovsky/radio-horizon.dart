// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_garden/radio_garden.dart';
import 'package:time_ago_provider/time_ago_provider.dart';

String getCurrentMemoryString() {
  final current = (ProcessInfo.currentRss / 1024 / 1024).toStringAsFixed(2);
  final rss = (ProcessInfo.maxRss / 1024 / 1024).toStringAsFixed(2);
  return '$current/$rss MB';
}

final _enInfoCommand = AppLocale.en.translations.commands.info;

ChatCommand info = ChatCommand(
  _enInfoCommand.command,
  _enInfoCommand.description,
  id('info', (IChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).info;

    final client = context.client as INyxxWebsocket;
    final color = getRandomColor();

    await usage?.sendEvent(
      'ChatCommand:info',
      'call',
      parameters: {
        'guild': context.guild?.id.toString() ?? 'null',
        'guild_name': context.guild?.name ?? 'null',
        'guild_preferred_locale': context.guild?.preferredLocale ?? 'null',
        'channel': context.channel.id.toString(),
        'user': context.member?.id.toString() ?? 'null',
      },
    );

    final button = LinkButtonBuilder(
      commandTranslations.addToServer,
      client.app.getInviteUrl(),
    );

    final embed = EmbedBuilder()
      ..color = color
      ..addAuthor((author) {
        author
          ..name = client.self.tag
          ..iconUrl = client.self.avatarURL()
          ..url = 'https://github.com/tomassasovsky/radio-garden.dart';
      })
      ..addFooter((footer) {
        footer.text = 'Radio Garden'
            ' | ${commandTranslations.shardOf(
          index: context.guild?.shard.id ?? 0 + 1,
          count: client.shards,
        )}'
            '${client.shards}'
            ' | Dart SDK version ${Platform.version.split('(').first}';
      })
      ..addField(
        name: commandTranslations.cachedGuilds,
        content: context.client.guilds.length,
        inline: true,
      )
      ..addField(
        name: commandTranslations.cachedUsers,
        content: context.client.users.length,
        inline: true,
      )
      ..addField(
        name: commandTranslations.cachedChannels,
        content: context.client.channels.length,
        inline: true,
      )
      ..addField(
        name: commandTranslations.cachedVoiceStates,
        content: context.client.guilds.values
            .map((g) => g.voiceStates.length)
            .reduce((value, element) => value + element),
        inline: true,
      )
      ..addField(
        name: commandTranslations.shardCount,
        content: client.shards,
        inline: true,
      )
      ..addField(
        name: commandTranslations.cachedMessages,
        content: context.client.channels.values
            .whereType<ITextChannel>()
            .map((c) => c.messageCache.length)
            .reduce((value, element) => value + element),
        inline: true,
      )
      ..addField(
        name: commandTranslations.memoryUsage,
        content: getCurrentMemoryString(),
        inline: true,
      )
      ..addField(
        name: commandTranslations.uptime,
        content: formatFull(context.client.startTime),
        inline: true,
      );

    final messageBuilder = ComponentMessageBuilder()
      ..embeds = [embed]
      ..addComponentRow(ComponentRowBuilder()..addComponent(button));

    await context.respond(messageBuilder);
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.info.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.info.command,
  ),
);
