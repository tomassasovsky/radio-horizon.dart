import 'package:injector/injector.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:radio_horizon/src/checks.dart';
import 'package:radio_horizon/src/helpers/music_queue.dart';

final _enSkipCommand = AppLocale.en.translations.commands.skip;
final _enStopCommand = AppLocale.en.translations.commands.stop;
final _enJoinCommand = AppLocale.en.translations.commands.join;
final _enLeaveCommand = AppLocale.en.translations.commands.leave;
final _enPauseCommand = AppLocale.en.translations.commands.pause;
final _enResumeCommand = AppLocale.en.translations.commands.resume;
final _enVolumeCommand = AppLocale.en.translations.commands.volume;

final skip = ChatCommand(
  _enSkipCommand.command,
  _enSkipCommand.description,
  checks: [botConnectedToAVoiceChannelCheck],
  id('skip', (ChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).skip;
    final playCommandTranslations =
        getCommandTranslations(context).music.children.play;

    final player = await connectLavalink(context);
    if (player == null) {
      await context
          .respond(MessageBuilder(content: commandTranslations.nothingPlaying));
      return;
    }

    final queue = trackQueues.getOrCreateQueue(player);
    if (queue.isEmpty) {
      await context
          .respond(MessageBuilder(content: commandTranslations.nothingPlaying));
      return;
    }

    final next = queue.skip();

    if (next != null) {
      await context.respond(
        MessageBuilder(
          content: playCommandTranslations.songEnqueued(
            title: next.info.title,
            query: 'from queue',
          ),
        ),
      );
    } else {
      await context
          .respond(MessageBuilder(content: commandTranslations.skipped));
    }
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.skip.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.skip.command,
  ),
);

final leave = ChatCommand(
  _enLeaveCommand.command,
  _enLeaveCommand.description,
  checks: [botConnectedToAVoiceChannelCheck],
  id('leave', (ChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).leave;

    final nyxxGateway = Injector.appInstance.get<NyxxGateway>();

    final player = await connectLavalink(context);
    if (player != null) {
      final queue = trackQueues.getOrCreateQueue(player);
      queue.clear();
    }

    nyxxGateway.updateVoiceState(
      context.guild!.id,
      GatewayVoiceStateBuilder(
        channelId: null,
        isMuted: false,
        isDeafened: false,
      ),
    );

    await context.respond(MessageBuilder(content: commandTranslations.left));
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.leave.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.leave.command,
  ),
);

final join = ChatCommand(
  _enJoinCommand.command,
  _enJoinCommand.description,
  checks: [botNotConnectedToAVoiceChannelCheck],
  id('join', (ChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).join;

    await connectLavalink(context);

    await context.respond(MessageBuilder(content: commandTranslations.joined));
  }),
  localizedDescriptions:
      localizedValues((translations) => translations.commands.join.description),
  localizedNames:
      localizedValues((translations) => translations.commands.join.command),
);

final volume = ChatCommand(
  _enVolumeCommand.command,
  _enVolumeCommand.description,
  checks: [botConnectedToAVoiceChannelCheck],
  id('volume', (
    ChatContext context,
    @Description(
      'The new volume, this value must be contained between 0 and 1000',
    )
    @UseConverter(IntConverter(min: 0, max: 1000))
    int volume,
  ) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).volume;

    final player = await connectLavalink(context);
    await player?.setVolume(volume);

    await context.respond(
      MessageBuilder(
        content: commandTranslations.volumeSet(volume: volume),
      ),
    );
  }),
  localizedDescriptions: localizedValues((t) => t.commands.volume.description),
  localizedNames: localizedValues((t) => t.commands.volume.command),
);

final pause = ChatCommand(
  _enPauseCommand.command,
  _enPauseCommand.description,
  id('pause', (ChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).pause;

    final player = await connectLavalink(context);
    await player?.pause();

    await context.respond(MessageBuilder(content: commandTranslations.paused));
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.pause.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.pause.command,
  ),
);

final resume = ChatCommand(
  _enResumeCommand.command,
  _enResumeCommand.description,
  id('resume', (ChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).resume;

    final player = await connectLavalink(context);
    await player?.resume();

    await context.respond(MessageBuilder(content: commandTranslations.resumed));
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
  checks: [botConnectedToAVoiceChannelCheck],
  id('stop', (ChatContext context) async {
    context as InteractionChatContext;
    final commandTranslations = getCommandTranslations(context).stop;

    final player = await connectLavalink(context);

    if (player != null) {
      final queue = trackQueues.getOrCreateQueue(player);
      queue.clear();
    }

    await context.respond(MessageBuilder(content: commandTranslations.stopped));
  }),
  localizedDescriptions: localizedValues(
    (translations) => translations.commands.stop.description,
  ),
  localizedNames: localizedValues(
    (translations) => translations.commands.stop.command,
  ),
);
