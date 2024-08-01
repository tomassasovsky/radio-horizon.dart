// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:time_ago_provider/time_ago_provider.dart';

String getCurrentMemoryString() {
  final current = (ProcessInfo.currentRss / 1024 / 1024).toStringAsFixed(2);
  final rss = (ProcessInfo.maxRss / 1024 / 1024).toStringAsFixed(2);
  return '$current/$rss MB';
}

final _enInfoCommand = AppLocale.en.translations.commands.info;
final _logger = Logger('command/info');

final _getIt = GetIt.instance;

ChatCommand info = ChatCommand(
  _enInfoCommand.command,
  _enInfoCommand.description,
  id('info', (IChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).info;
    final nodes = _getIt.get<MusicService>().cluster.connectedNodes;
    final players = nodes.values
        .map((b) => b.players.length)
        .reduce((value, element) => value + element);

    final client = context.client as INyxxWebsocket;
    final color = getRandomColor();

    _logger.info(
      '''
ChatCommand:info:call: {
  'guild': ${context.guild?.id ?? 'null'},
  'guild_name': ${context.guild?.name ?? 'null'},
  'guild_preferred_locale': ${context.guild?.preferredLocale ?? 'null'},
  'channel': ${context.channel.id},
  'user': ${context.member?.id.toString() ?? 'null'},
}''',
    );

    final button = LinkButtonBuilder(
      commandTranslations.addToServer,
      client.app.getInviteUrl(),
    );

    final gatewayLatency = (context.client as INyxxWebsocket)
        .shardManager
        .gatewayLatency
        .inMilliseconds;

    final embed = EmbedBuilder()
      ..color = color
      ..addAuthor((author) {
        author
          ..name = client.self.tag
          ..iconUrl = client.self.avatarUrl()
          ..url = 'https://github.com/tomassasovsky/radio-horizon.dart';
      })
      ..addFooter((footer) {
        footer.text = 'Radio Horizon'
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
        name: commandTranslations.currentPlayers,
        content: players,
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
      )
      ..addField(
        name: commandTranslations.gatewayLatency,
        content: gatewayLatency,
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
