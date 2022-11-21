// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dotenv/dotenv.dart';

enum DotEnvFlavour {
  development('.env/.env.development'),
  production('.env/.env.production');

  const DotEnvFlavour(this.path);

  final String path;
  Future<void> initialize() async {
    _dotEnv = DotEnv(includePlatformEnvironment: true);
    return dotenv.load([path]);
  }

  DotEnv get dotenv => _dotEnv;
}

var _dotEnv = DotEnv(includePlatformEnvironment: true);
late DotEnvFlavour dotEnvFlavour;
