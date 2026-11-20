// Copyright (c) 2024, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:mocktail/mocktail.dart';
import 'package:nyxx/nyxx.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:test/test.dart';

class _MockApplicationCommand extends Mock implements ApplicationCommand {}

ApplicationCommand _command(int typeValue) {
  final command = _MockApplicationCommand();
  when(() => command.type).thenReturn(ApplicationCommandType(typeValue));
  return command;
}

void main() {
  group('entryPointCommandType', () {
    test('matches Discord PRIMARY_ENTRY_POINT (4)', () {
      expect(entryPointCommandType, 4);
    });
  });

  group('entryPointCommands', () {
    test('selects only Primary Entry Point commands', () {
      final chatInput = _command(1);
      final user = _command(2);
      final message = _command(3);
      final entryPoint = _command(entryPointCommandType);

      final result = entryPointCommands([chatInput, user, message, entryPoint]);

      expect(result, [entryPoint]);
    });

    test('returns every Entry Point command when more than one exists', () {
      final first = _command(entryPointCommandType);
      final second = _command(entryPointCommandType);

      expect(entryPointCommands([first, _command(1), second]), [first, second]);
    });

    test('returns empty when no Entry Point command is present', () {
      final commands = [_command(1), _command(2), _command(3)];
      expect(entryPointCommands(commands), isEmpty);
    });

    test('returns empty for an empty list', () {
      expect(entryPointCommands(const <ApplicationCommand>[]), isEmpty);
    });
  });
}
