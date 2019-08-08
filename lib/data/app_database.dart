import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  static const String APP_DATABASE_NAME = 'demo.db';
  //singleton instance
  static final AppDatabase _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;

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
        await getApplicationSupportDirectory(); //TODO: testing on documents path, move to app files directory
    final dbPath = join(appdocumentDir.path, APP_DATABASE_NAME);
    final database = createDatabaseFactoryIo().openDatabase(dbPath);


    _dbOpenCompleter.complete(database);
  }
}
