// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:math';
import 'package:nyxx/nyxx.dart';

DiscordColor getRandomColor() {
  final random = Random();

  return DiscordColor.fromRgb(
    random.nextInt(255),
    random.nextInt(255),
    random.nextInt(255),
  );
}
