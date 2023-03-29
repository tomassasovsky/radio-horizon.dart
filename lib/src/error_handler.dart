// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:radio_horizon/radio_horizon.dart';

final _logger = Logger('ROD.CommandErrors');

Future<void> commandErrorHandler(CommandsException error) async {
  if (error is CommandInvocationException) {
    final context = error.context;

    final locale = context.guild?.preferredLocale ?? Locale.englishUs.code;
    final translations = AppLocaleUtils.parse(locale).translations;

    String? title;
    String? description;

    if (error is CheckFailedException) {
      if (error.failed.name.contains('music')) {
        switch (error.failed.name) {
          case 'musicConnectedToVC':
            await context.respond(
              MessageBuilder.content(
                translations.errorHandler.musicConnectedToVC,
              ),
            );
            break;
          case 'musicNotConnectedToVC':
            await context.respond(
              MessageBuilder.content(
                translations.errorHandler.musicNotConnectedToVC,
              ),
            );
            break;
          case 'musicSameVC':
            await context.respond(
              MessageBuilder.content(
                translations.errorHandler.musicSameVC,
              ),
            );
            break;
          case 'musicUserConnectedToVC':
            await context.respond(
              MessageBuilder.content(
                translations.errorHandler.musicUserConnectedToVC,
              ),
            );
            break;
          default:
            break;
        }

        return;
      }

      final failed = error.failed;

      if (failed is CooldownCheck) {
        title = translations.errorHandler.cooldown.title;
        description = translations.errorHandler.cooldown.description(
          inSeconds: failed.remaining(context).inSeconds,
        );
      } else {
        title = translations.errorHandler.unauthorizedCommand.title;
        description = translations.errorHandler.unauthorizedCommand.description;
      }
    } else if (error is NotEnoughArgumentsException) {
      title = translations.errorHandler.missingArguments.title;
      description = translations.errorHandler.missingArguments.description;
    } else if (error is BadInputException) {
      title = translations.errorHandler.inputParsingFailure.title;
      description = translations.errorHandler.inputParsingFailure.description;
    } else if (error is UncaughtException) {
      _logger.severe('Uncaught exception in command: ${error.exception}');
    }

    // Send a generic "an error occurred" response
    final embed = EmbedBuilder()
      ..color = DiscordColor.red
      ..title = title ?? translations.errorHandler.title
      ..description =
          description ?? translations.errorHandler.fallbackDescription
      ..addFooter((footer) {
        footer.text = error.runtimeType.toString();
      })
      ..timestamp = DateTime.now();

    await context.respond(MessageBuilder.embed(embed));
    return;
  }

  _logger.shout('Unhandled exception: $error');
}
