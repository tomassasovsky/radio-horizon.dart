import 'package:mongo_dart/mongo_dart.dart';
import 'package:nyxx/nyxx.dart';
import 'package:radio_garden/src/settings.dart';

class DatabaseService {
  DatabaseService._(this._client) {
    _client.onReady.listen((_) async {
      await _initialize();
      await _addServer();
    });
  }

  static DatabaseService get instance =>
      _instance ??
      (throw Exception(
        'DB service must be initialised with DB.init',
      ));

  static DatabaseService? _instance;

  late Db _db;

  Future<void> _initialize() async {
    final mongoConnection = getEnv('MONGO_CONNECTION');

    /// Connects to the MongoDB database
    _db = await Db.create(mongoConnection);
    await _db.open();
  }

  Future<void> _addServer() async {
    _client.eventsWs.onGuildCreate.listen((event) {
      serverCollection.insert({'guildId': event.guild.id.id});
    });
  }

  DbCollection get serverCollection => _db.collection('servers');

  final INyxxWebsocket _client;

  static void init(INyxxWebsocket client) {
    _instance = DatabaseService._(client);
  }
}
