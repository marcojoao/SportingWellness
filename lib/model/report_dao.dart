import 'package:Wellness/data/app_database.dart';
import 'package:Wellness/model/report.dart';
import 'package:sembast/sembast.dart';

class ReportDAO {
  static const String REPORT_STORE_NAME = 'reports';

  final _reportStore = intMapStoreFactory.store(REPORT_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Report report) async {
    await _reportStore.add(await _db, report.toMap());
  }

  Future update(Report report) async {
    final finder = Finder(filter: Filter.byKey(report.id));

    await _reportStore.update(await _db, report.toMap(), finder: finder);
  }

  Future delete(Report report) async {
    final finder = Finder(filter: Filter.byKey(report.id));

    await _reportStore.delete(await _db, finder: finder);
  }

  Future<List<Report>> getAllByDateTime(String dateTime) async {
    final finder =
        Finder(filter: Filter.equals('dateTime', dateTime), sortOrders: [
      SortOrder('dateTime'),
    ]);

    final recordSnapshots = await _reportStore.find(await _db, finder: finder);

    return recordSnapshots.map((snapshot) {
      final report = Report.fromMap(snapshot.value);
      report.id = snapshot.key;
      return report;
    }).toList();
  }

  Future<List<Report>> getAllById(int playerId) async {
    final finder =
        Finder(filter: Filter.equals('playerId', playerId), sortOrders: [
      SortOrder('dateTime'),
    ]);

    final recordSnapshots = await _reportStore.find(await _db, finder: finder);

    return recordSnapshots.map((snapshot) {
      final report = Report.fromMap(snapshot.value);
      report.id = snapshot.key;
      return report;
    }).toList();
  }
}
