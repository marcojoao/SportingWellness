import 'dart:async';
import 'package:Wellness/model/dao/report_dao.dart';
import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportDAO _reportDAO = ReportDAO();

  @override
  ReportState get initialState => InitialReportState();

  @override
  Stream<ReportState> mapEventToState(
    ReportEvent event,
  ) async* {
    if (event is LoadReports) {
      yield ReportsLoading();
      yield* _reloadReports(null);
    } else if (event is LoadReportsByPlayer) {
      yield ReportsLoading();
      yield* _reloadReports(event.player);
    } else if (event is AddReport) {
      await _reportDAO.insert(event.insertReport);
      yield* _reloadReports(null);
    } else if (event is UpdateWithReport) {
      final newReport = event.updatedReport;
      newReport.id = event.updatedReport.id;
      await _reportDAO.update(newReport);
      yield* _reloadReports(null);
    } else if (event is DeleteReport) {
      await _reportDAO.delete(event.report);
      yield* _reloadReports(null);
    }
  }

  Stream<ReportState> _reloadReports(Player player) async* {
    print("_reloadReports");
    List<Report> reports;
    if (player == null) {
      reports = await _reportDAO.getAllByDateTime(null);
    } else {
      reports = await _reportDAO.getAllById(player.id);
    }

    yield ReportsLoaded(reports);
  }
}
