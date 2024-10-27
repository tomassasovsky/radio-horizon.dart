// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';

import 'package:injector/injector.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_extensions/nyxx_extensions.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';
import 'package:radio_horizon/radio_horizon.dart';

String getCurrentMemoryString() {
  final current = (ProcessInfo.currentRss / 1024 / 1024).toStringAsFixed(2);
  final rss = (ProcessInfo.maxRss / 1024 / 1024).toStringAsFixed(2);
  return '$current/$rss MB';
}

final _enInfoCommand = AppLocale.en.translations.commands.info;

ChatCommand info = ChatCommand(
  _enInfoCommand.command,
  _enInfoCommand.description,
  id('info', (ChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).info;

    final color = getRandomColor();
    final currentUser = await context.client.user.get();
    final players =
        await Injector.appInstance.get<LavalinkClient>().listPlayers();

    final startDate = Injector.appInstance.get<BotStartDuration>().startDate;
    final startDateStr = '${startDate.format(TimestampStyle.longDateTime)} '
        '(${startDate.format(TimestampStyle.relativeTime)})';

    final embed = EmbedBuilder(
      color: color,
      author: EmbedAuthorBuilder(
        name: currentUser.username,
        iconUrl: currentUser.avatar.url,
        url: Uri.parse(githubUrl),
      ),
      footer: EmbedFooterBuilder(
        text: 'nyxx ${ApiOptions.nyxxVersion}'
            ' | Radio Horizon $packageVersion'
            ' | Dart SDK ${getDartPlatform()}',
        iconUrl: currentUser.avatar.url,
      ),
      fields: [
        EmbedFieldBuilder(
          name: commandTranslations.cachedGuilds,
          value: context.client.guilds.cache.length.toString(),
          isInline: true,
        ),
        EmbedFieldBuilder(
          name: commandTranslations.cachedUsers,
          value: context.client.users.cache.length.toString(),
          isInline: true,
        ),
        EmbedFieldBuilder(
          name: commandTranslations.cachedChannels,
          value: context.client.channels.cache.length.toString(),
          isInline: true,
        ),
        EmbedFieldBuilder(
          name: commandTranslations.currentPlayers,
          value: players
              .where((p) => p.state.isConnected && p.track != null)
              .length
              .toString(),
          isInline: true,
        ),
        EmbedFieldBuilder(
          name: commandTranslations.shardCount,
          value: context.client.gateway.shards.length.toString(),
          isInline: true,
        ),
        EmbedFieldBuilder(
          name: commandTranslations.cachedMessages,
          value: context.client.channels.cache.values
              .whereType<TextChannel>()
              .map((c) => c.messages.cache.length)
              .fold<num>(0, (value, element) => value + element)
              .toString(),
          isInline: true,
        ),
        EmbedFieldBuilder(
          name: commandTranslations.memoryUsage,
          value: getCurrentMemoryString(),
          isInline: true,
        ),
        EmbedFieldBuilder(
          name: commandTranslations.uptime,
          value: startDateStr,
          isInline: false,
        ),
      ],
    );

    final inviteButton = ButtonBuilder.link(
      url: context.client.application.getInviteUri(
        scopes: ['bot', 'applications.commands'],
      ),
      label: commandTranslations.addToServer,
    );

    final githubStarButton = ButtonBuilder.link(
      url: Uri.parse(githubUrl),
      label: commandTranslations.viewOnGithub,
    );

    await context.respond(
      MessageBuilder(
        embeds: [embed],
        components: [
          ActionRowBuilder(
            components: [
              inviteButton,
              githubStarButton,
            ],
          ),
        ],
      ),
    );
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.info.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.info.command,
  ),
);
