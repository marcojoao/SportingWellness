import 'package:sembast/sembast.dart';
import 'package:Wellness/data/app_database.dart';
import 'package:Wellness/model/player.dart';

class PlayersDAO {
  static const String PLAYER_STORE_NAME = 'players';

  final _playerStore = intMapStoreFactory.store(PLAYER_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Player player) async {
    await _playerStore.add(await _db, player.toMap());
  }

  Future update(Player player) async {
    final finder = Finder(filter: Filter.byKey(player.id));

    await _playerStore.update(await _db, player.toMap(), finder: finder);
  }

  Future delete(Player player) async {
    final finder = Finder(filter: Filter.byKey(player.id));

    await _playerStore.delete(await _db, finder: finder);
  }

  Future<List<Player>> getAllSortedByName() async {
    final finder = Finder(sortOrders: [
      SortOrder('name'),
    ]);

    final recordSnapshots = await _playerStore.find(await _db, finder: finder);

    return recordSnapshots.map((snapshot) {
      final player = Player.fromMap(snapshot.value);
      player.id = snapshot.key;
      return player;
    }).toList();
  }
}
