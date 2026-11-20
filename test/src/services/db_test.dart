// Copyright (c) 2024, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:mocktail/mocktail.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:nyxx/nyxx.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:test/test.dart';

class _MockDbCollection extends Mock implements DbCollection {}

class _MockWriteResult extends Mock implements WriteResult {}

class _MockStation extends Mock implements Station {}

/// Exposes an injectable [radioPlayingCollection] so `setPlaying` can be tested
/// without a live MongoDB connection.
class _TestDatabaseService extends DatabaseService {
  _TestDatabaseService(this._collection);

  final DbCollection _collection;

  @override
  DbCollection get radioPlayingCollection => _collection;
}

void main() {
  setUpAll(() {
    registerFallbackValue(where);
    registerFallbackValue(<String, dynamic>{});
  });

  group('DatabaseService.setPlaying', () {
    late _MockDbCollection collection;
    late _TestDatabaseService service;

    setUp(() {
      collection = _MockDbCollection();
      service = _TestDatabaseService(collection);
      when(
        () => collection.replaceOne(
          any<SelectorBuilder>(),
          any(),
          upsert: any(named: 'upsert'),
        ),
      ).thenAnswer((_) async => _MockWriteResult());
    });

    GuildRadio buildRadio() {
      final station = _MockStation();
      when(station.toJson).thenReturn(<String, dynamic>{
        'name': 'Aspen 102.3 (AAC)',
      });
      return GuildRadio(
        Snowflake.parse('977800310804332574'),
        station: station,
        voiceChannelId: Snowflake.parse('456'),
        textChannelId: Snowflake.parse('789'),
      );
    }

    test('upserts the guild document rather than inserting a new one',
        () async {
      await service.setPlaying(buildRadio());

      final captured = verify(
        () => collection.replaceOne(
          any<SelectorBuilder>(),
          captureAny(),
          upsert: captureAny(named: 'upsert'),
        ),
      ).captured;

      final update = captured[0] as Map<String, dynamic>;
      final upsert = captured[1] as bool?;

      // Must upsert so a station change replaces the guild's existing record
      // instead of failing on the unique guildId index.
      expect(upsert, isTrue);
      expect(update['guildId'], '977800310804332574');
      expect(update['station'], {'name': 'Aspen 102.3 (AAC)'});

      // A plain insert is what caused the stale-station bug.
      verifyNever(() => collection.insert(any()));
    });
  });
}
