import 'dart:math';

const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoP' // pragma: allowlist secret
    'pQqRrSsTtUuVvWwXxYyZz1234567890'; // pragma: allowlist secret
final rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
