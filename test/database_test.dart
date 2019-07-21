import 'package:flutter_test/flutter_test.dart';

import 'package:sembast/sembast.dart';
import 'package:sporting_performance/data/app_database.dart';

import 'package:sporting_performance/main.dart';
import 'package:sporting_performance/model/player.dart';
import 'package:sporting_performance/model/player_dao.dart';

void main() {
  test('create instance player', () {
    final _player = Player(
        name: 'andy',
        age: 22,
        escalao: EscalaoType.juniors,
        avatarPath: 'ww',
        birtDate: DateTime.now());

    expect(_player, isA<Player>());
  });

  test('getdatabse creation', () async {
    Future<Database> dbFuture = AppDatabase.instance.database;
    var db = await dbFuture;
    expect(db, isA<Database>());
  });

  test("insert player into db", () async {
    PlayersDAO _playersDao = PlayersDAO();
    var res = await _playersDao.insert(Player(
        name: 'andy',
        age: 22,
        escalao: EscalaoType.juniors,
        avatarPath: 'ww',
        birtDate: DateTime.now()));

    print(res);
    expect(res, isNotNull);
  });
}
