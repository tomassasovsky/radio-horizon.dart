import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:radio_horizon/src/checks.dart';

final _enSkipCommand = AppLocale.en.translations.commands.skip;
final _enStopCommand = AppLocale.en.translations.commands.stop;
final _enJoinCommand = AppLocale.en.translations.commands.join;
final _enLeaveCommand = AppLocale.en.translations.commands.leave;
final _enPauseCommand = AppLocale.en.translations.commands.pause;
final _enResumeCommand = AppLocale.en.translations.commands.resume;
final _enVolumeCommand = AppLocale.en.translations.commands.volume;

final _skipLogger = Logger('command/skip');

final skip = ChatCommand(
  _enSkipCommand.command,
  _enSkipCommand.description,
  checks: [connectedToAVoiceChannelCheck],
  id('skip', (IChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).skip;

    _skipLogger.info(
      '''
ChatCommand:skip: {
  'guild': ${context.guild?.id.toString() ?? 'null'},
  'guild_name': ${context.guild?.name ?? 'null'},
  'guild_preferred_locale': ${context.guild?.preferredLocale ?? 'null'},
  'channel': ${context.channel.id},
  'user': ${context.member?.id.toString() ?? 'null'},
}''',
    );

    final node =
        MusicService.instance.cluster.getOrCreatePlayerNode(context.guild!.id);
    final player = node.players[context.guild!.id]!;

    if (player.queue.isEmpty) {
      await context.respond(
        MessageBuilder.content(commandTranslations.nothingPlaying),
      );
      return;
    }

    node.skip(context.guild!.id);
    await context.respond(
      MessageBuilder.content(commandTranslations.skipped),
    );
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.skip.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.skip.command,
  ),
);

final _leaveLogger = Logger('command/leave');

final leave = ChatCommand(
  _enLeaveCommand.command,
  _enLeaveCommand.description,
  checks: [connectedToAVoiceChannelCheck],
  id('leave', (IChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).leave;

    _leaveLogger.info(
      '''
ChatCommand:leave: {
  'guild': ${context.guild?.id.toString() ?? 'null'},
  'guild_name': ${context.guild?.name ?? 'null'},
  'guild_preferred_locale': ${context.guild?.preferredLocale ?? 'null'},
  'channel': ${context.channel.id},
  'user': ${context.member?.id.toString() ?? 'null'},
}''',
    );

    MusicService.instance.cluster
        .getOrCreatePlayerNode(context.guild!.id)
        .destroy(context.guild!.id);
    context.guild!.shard.changeVoiceState(context.guild!.id, null);
    await context.respond(MessageBuilder.content(commandTranslations.left));
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.leave.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.leave.command,
  ),
);

final _joinLogger = Logger('command/join');

final join = ChatCommand(
  _enJoinCommand.command,
  _enJoinCommand.description,
  checks: [notConnectedToAVoiceChannelCheck],
  id('join', (IChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).join;

    _joinLogger.info(
      '''
ChatCommand:join: {
  'guild': ${context.guild?.id.toString() ?? 'null'},
  'guild_name': ${context.guild?.name ?? 'null'},
  'guild_preferred_locale': ${context.guild?.preferredLocale ?? 'null'},
  'channel': ${context.channel.id},
  'user': ${context.member?.id.toString() ?? 'null'},
}''',
    );

    MusicService.instance.cluster.getOrCreatePlayerNode(context.guild!.id);
    await connectIfNeeded(context);
    await context.respond(MessageBuilder.content(commandTranslations.joined));
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.join.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.join.command,
  ),
);

final _volumeLogger = Logger('command/volume');

final volume = ChatCommand(
  _enVolumeCommand.command,
  _enVolumeCommand.description,
  checks: [connectedToAVoiceChannelCheck],
  id('volume', (
    IChatContext context,
    @Description(
      'The new volume, this value must be contained between 0 and 1000',
    )
    @UseConverter(IntConverter(min: 0, max: 1000))
    int volume,
  ) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).volume;

    _volumeLogger.info(
      '''
ChatCommand:volume: {
  'volume': $volume,
  'guild': ${context.guild?.id.toString() ?? 'null'},
  'guild_name': ${context.guild?.name ?? 'null'},
  'guild_preferred_locale': ${context.guild?.preferredLocale ?? 'null'},
  'channel': ${context.channel.id},
  'user': ${context.member?.id.toString() ?? 'null'},
}''',
    );

    MusicService.instance.cluster
        .getOrCreatePlayerNode(context.guild!.id)
        .volume(
          context.guild!.id,
          volume,
        );

    await context.respond(
      MessageBuilder.content(
        commandTranslations.volumeSet(volume: volume),
      ),
    );
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.volume.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.volume.command,
  ),
);

final _pauseLogger = Logger('command/pause');

final pause = ChatCommand(
  _enPauseCommand.command,
  _enPauseCommand.description,
  id('pause', (IChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).pause;

    _pauseLogger.info(
      '''
ChatCommand:pause: {
  'guild': ${context.guild?.id.toString() ?? 'null'},
  'guild_name': ${context.guild?.name ?? 'null'},
  'guild_preferred_locale': ${context.guild?.preferredLocale ?? 'null'},
  'channel': ${context.channel.id},
  'user': ${context.member?.id.toString() ?? 'null'},
}''',
    );

    MusicService.instance.cluster
        .getOrCreatePlayerNode(context.guild!.id)
        .pause(context.guild!.id);
    await context.respond(MessageBuilder.content(commandTranslations.paused));
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.pause.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.pause.command,
  ),
);

final _resumeLogger = Logger('command/resume');

final resume = ChatCommand(
  _enResumeCommand.command,
  _enResumeCommand.description,
  id('resume', (IChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).resume;

    _resumeLogger.info(
      '''
ChatCommand:resume: {
  'guild': ${context.guild?.id.toString() ?? 'null'},
  'guild_name': ${context.guild?.name ?? 'null'},
  'guild_preferred_locale': ${context.guild?.preferredLocale ?? 'null'},
  'channel': ${context.channel.id},
  'user': ${context.member?.id.toString() ?? 'null'},
}''',
    );

    MusicService.instance.cluster
        .getOrCreatePlayerNode(context.guild!.id)
        .resume(context.guild!.id);
    await context.respond(MessageBuilder.content(commandTranslations.resumed));
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.resume.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.resume.command,
  ),
);

final stop = ChatCommand(
  _enStopCommand.command,
  _enStopCommand.description,
  checks: [connectedToAVoiceChannelCheck],
  id('stop', (IChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).stop;

    _resumeLogger.info(
      '''
ChatCommand:stop: {
  'guild': ${context.guild?.id.toString() ?? 'null'},
  'guild_name': ${context.guild?.name ?? 'null'},
  'guild_preferred_locale': ${context.guild?.preferredLocale ?? 'null'},
  'channel': ${context.channel.id},
  'user': ${context.member?.id.toString() ?? 'null'},
}''',
    );

    MusicService.instance.cluster
        .getOrCreatePlayerNode(context.guild!.id)
        .stop(context.guild!.id);
    await context.respond(MessageBuilder.content(commandTranslations.stopped));
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.stop.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.stop.command,
  ),
);
