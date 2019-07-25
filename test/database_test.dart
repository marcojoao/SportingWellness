import 'package:flutter_test/flutter_test.dart';

import 'package:sembast/sembast.dart';
import 'package:Wellness/data/app_database.dart';

import 'package:Wellness/main.dart';
import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/player_dao.dart';

void main() {
  test('create instance player', () {
    final _player = Player(
      name: 'Marco',
      team: TeamType.u_23,
      height: 190,
      weight: 80,
      avatarPath: 'ww',
      birthDate: DateTime.now());

    expect(_player, isNotNull);
    expect(_player, isA<Player>());
  });

  // test('create instance Record', () {
  //   final record = Record();

  //   expect(record, isNotNull);
  //   expect(record, isA<Record>());
  // });
  test('getdatabse creation', () async {
    Future<Database> dbFuture = AppDatabase.instance.database;
    var db = await dbFuture;
    expect(db, isA<Database>());
  });

  test("insert player into db", () async {
    PlayersDAO _playersDao = PlayersDAO();
    var res = await _playersDao.insert(Player(
      name: 'Andy',
      team: TeamType.u_23,
      height: 190,
      weight: 80,
      avatarPath: 'ww',
      birthDate: DateTime.now()));

    print(res);
    expect(res, isNotNull);
  });
}

class DatabaseTestContext {
  DatabaseFactory factory;

  // String dbPath;

  // Delete the existing and open the database
  // ignore: always_require_non_null_named_parameters
  Future<Database> open(String dbPath, {int version}) async {
    assert(dbPath != null, 'dbPath cannot be null');
    // this.dbPath = dbPath;

    await factory.deleteDatabase(dbPath);
    return await factory.openDatabase(dbPath, version: version);
  }
}

void unused(dynamic value) {}
