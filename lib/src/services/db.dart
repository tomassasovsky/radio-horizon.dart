import 'dart:async';

import 'package:logging/logging.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:nyxx/nyxx.dart';
import 'package:radio_browser_api/radio_browser_api.dart';
import 'package:radio_horizon/radio_horizon.dart';

class DatabaseService {
  DatabaseService(this._client) {
    _client.onReady.listen((_) async {
      await _addServer();
    });
  }

  late Db _db;

  Future<void> _checkConnection() async {
    if (!_db.isConnected) {
      await _db.open();
    }
  }

  Future<void> initialize() async {
    /// Connects to the MongoDB database
    _db = await Db.create(mongoDBConnection);
    await _db.open();

    await _db.collection('servers').createIndex(
          key: 'guildId',
          unique: true,
        );

    await _db.collection('radioPlaying').createIndex(
          key: 'guildId',
          unique: true,
        );
  }

  Future<void> _addServer() async {
    _client.eventsWs.onGuildCreate.listen((event) async {
      try {
        await _checkConnection();
        await serverCollection.insert({'guildId': event.guild.id.id});
      } catch (e, stackTrace) {
        Logger('DB').warning('Error while adding server to db', e, stackTrace);
      }
    });
  }

  Future<void> setPlaying(GuildRadio guildRadio) async {
    try {
      await _checkConnection();
      await radioPlayingCollection.insert(guildRadio.toJson());
    } catch (e, stackTrace) {
      Logger('DB').warning('Error while setting playing to db', e, stackTrace);
    }
  }

  /// Gets the current radio playing by Guild.
  ///
  /// Throws [RadioNotPlayingException] if the Guild is not listening
  /// to the radio
  Future<GuildRadio> currentRadio(Snowflake guildId) async {
    final currentlyPlaying = await getPlaying(guildId);
    if (currentlyPlaying == null) {
      throw const RadioNotPlayingException();
    }

    return currentlyPlaying;
  }

  /// Adds or not the current radio that the guild is playing
  Future<void> setCurrentRadio(
    Snowflake guildId,
    Snowflake voiceChannelId,
    Snowflake textChannelId,
    Station station,
  ) async {
    final newRadio = GuildRadio(
      guildId,
      voiceChannelId: voiceChannelId,
      station: station,
      textChannelId: textChannelId,
    );

    await setPlaying(newRadio);
  }

  /// Deletes the radio from the [SongRecognitionService] radio. This is to let
  /// the service know that the guild is no longer listening to the radio.
  Future<void> deleteRadioFromList(Snowflake guildId) async {
    await setNotPlaying(guildId);
  }

  Future<GuildRadio?> getPlaying(Snowflake guildId) async {
    try {
      await _checkConnection();
      final res = await radioPlayingCollection.findOne(
        where.eq('guildId', guildId.toString()),
      );

      if (res == null) {
        return null;
      }

      return GuildRadio.fromJson(res);
    } catch (e, stackTrace) {
      Logger('DB').warning(
        'Error while getting playing from db',
        e,
        stackTrace,
      );
    }

    return null;
  }

  Future<List<GuildRadio>?> getAllPlaying() async {
    try {
      await _checkConnection();
      final res = await radioPlayingCollection.find().toList();

      if (res.isEmpty) {
        return null;
      }

      return res.map(GuildRadio.fromJson).toList();
    } catch (e, stackTrace) {
      Logger('DB').warning(
        'Error while getting all stations playing from db',
        e,
        stackTrace,
      );
    }

    return null;
  }

  Future<void> setNotPlaying(Snowflake guildId) async {
    try {
      await _checkConnection();
      await radioPlayingCollection.remove(
        where.eq('guildId', guildId.toString()),
      );
    } catch (e, stackTrace) {
      Logger('DB').warning(
        'Error while setting not playing to db',
        e,
        stackTrace,
      );
    }
  }

  DbCollection get serverCollection => _db.collection('servers');
  DbCollection get radioPlayingCollection => _db.collection('radioPlaying');

  final INyxxWebsocket _client;

  FutureOr<void> close() async => _db.close();
}
