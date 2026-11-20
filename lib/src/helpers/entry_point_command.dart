// Copyright (c) 2024, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:nyxx/nyxx.dart';

/// The [ApplicationCommandType] value Discord uses for a Primary Entry Point
/// command.
///
/// nyxx 6.9.1 does not define this type, so it is referenced by its raw value.
const entryPointCommandType = 4;

/// Returns the Primary Entry Point commands contained in [commands].
///
/// Discord automatically adds a Primary Entry Point command (type
/// [entryPointCommandType]) to every application. When nyxx_commands syncs the
/// bot's slash commands it calls
/// [GlobalApplicationCommandManager.bulkOverride], which omits this command.
/// Discord then rejects the whole bulk update with error `50240`:
///
/// > You cannot remove this app's Entry Point command in a bulk update
/// > operation. Please include the Entry Point command in your update request
/// > or delete it separately.
Iterable<ApplicationCommand> entryPointCommands(
  Iterable<ApplicationCommand> commands,
) =>
    commands.where((command) => command.type.value == entryPointCommandType);

/// Deletes the application's Primary Entry Point command, if one exists, so the
/// slash-command sync performed by nyxx_commands is not rejected with error
/// `50240` (see [entryPointCommands]).
///
/// Discord's own error message suggests deleting the command separately, which
/// is exactly what this does — a bulk overwrite that omits a command is only
/// rejected when that command still exists.
///
/// This is best-effort: any failure is logged and swallowed so it can never
/// abort bot startup. It is safe to call on every boot; when there is no Entry
/// Point command it performs a single read and returns.
Future<void> removeEntryPointCommand(String token, {Logger? logger}) async {
  final log = logger ?? Logger('ROD.EntryPointCommand');

  NyxxRest? rest;
  try {
    rest = await Nyxx.connectRest(token);

    final toDelete = entryPointCommands(await rest.commands.list()).toList();
    if (toDelete.isEmpty) return;

    for (final command in toDelete) {
      await rest.commands.delete(command.id);
      log.info(
        'Deleted Primary Entry Point command ${command.id} before command sync',
      );
    }
  } on Object catch (error, stackTrace) {
    log.warning(
      'Failed to remove the Primary Entry Point command; continuing startup',
      error,
      stackTrace,
    );
  } finally {
    await rest?.close();
  }
}
