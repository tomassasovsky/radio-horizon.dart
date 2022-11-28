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
import 'package:radio_garden/src/util.dart';
import 'package:time_ago_provider/time_ago_provider.dart';

String getCurrentMemoryString() {
  final current = (ProcessInfo.currentRss / 1024 / 1024).toStringAsFixed(2);
  final rss = (ProcessInfo.maxRss / 1024 / 1024).toStringAsFixed(2);
  return '$current/$rss MB';
}

ChatCommand info = ChatCommand(
  'info',
  'Get generic information about the bot',
  id('info', (IChatContext context) async {
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
      'Add Radio Garden to your server',
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
            ' | Shard ${(context.guild?.shard.id ?? 0) + 1} of '
            '${client.shards}'
            ' | Dart SDK version ${Platform.version.split('(').first}';
      })
      ..addField(
        name: 'Cached guilds',
        content: context.client.guilds.length,
        inline: true,
      )
      ..addField(
        name: 'Cached users',
        content: context.client.users.length,
        inline: true,
      )
      ..addField(
        name: 'Cached channels',
        content: context.client.channels.length,
        inline: true,
      )
      ..addField(
        name: 'Cached voice states',
        content: context.client.guilds.values
            .map((g) => g.voiceStates.length)
            .reduce((value, element) => value + element),
        inline: true,
      )
      ..addField(
        name: 'Shard count',
        content: client.shards,
        inline: true,
      )
      ..addField(
        name: 'Cached messages',
        content: context.client.channels.values
            .whereType<ITextChannel>()
            .map((c) => c.messageCache.length)
            .reduce((value, element) => value + element),
        inline: true,
      )
      ..addField(
        name: 'Memory usage (current/RSS)',
        content: getCurrentMemoryString(),
        inline: true,
      )
      ..addField(
        name: 'Uptime',
        content: formatFull(context.client.startTime),
        inline: true,
      );

    final messageBuilder = ComponentMessageBuilder()
      ..embeds = [embed]
      ..addComponentRow(ComponentRowBuilder()..addComponent(button));

    await context.respond(messageBuilder);
  }),
);
