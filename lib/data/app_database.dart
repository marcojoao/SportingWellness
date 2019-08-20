import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Wellness/model/dao/player_dao.dart';
import 'package:Wellness/tests/players_mock_list.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  static const String APP_DATABASE_NAME = 'demo.db';
  //singleton instance
  static final AppDatabase _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;
  PlayersDAO playersDAO = PlayersDAO();

  Completer<Database> _dbOpenCompleter;

  AppDatabase._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final appdocumentDir =
        await getApplicationDocumentsDirectory(); //TODO: testing on documents path, move to app files directory
    final dbPath = join(appdocumentDir.path, APP_DATABASE_NAME);
    //TODO: REMOVE this
    print("DBPATH ----------------------------------------- ${dbPath}");
    if (FileSystemEntity.typeSync(dbPath) != FileSystemEntityType.notFound) {
      createDatabaseFactoryIo().deleteDatabase(dbPath);
      // var config = new File(dbPath);
      // config.readAsLines().then((handleLines) => {print(handleLines)});
    }
    for (var item in players) {
      await playersDAO.insert(item);
    }
    final database = createDatabaseFactoryIo().openDatabase(dbPath);

    _dbOpenCompleter.complete(database);
  }
}
