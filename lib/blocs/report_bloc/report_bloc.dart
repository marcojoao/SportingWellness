import 'dart:async';
import 'package:Wellness/model/dao/report_dao.dart';
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
      yield* _reloadReports();
    } else if (event is AddReport) {
      await _reportDAO.insert(event.insertReport);
      yield* _reloadReports();
    } else if (event is UpdateWithReport) {
      final newReport = event.updatedReport;
      newReport.id = event.updatedReport.id;
      await _reportDAO.update(newReport);
      yield* _reloadReports();
    } else if (event is DeleteReport) {
      await _reportDAO.delete(event.report);
      yield* _reloadReports();
    }
  }

  Stream<ReportState> _reloadReports() async* {
    final player = await _reportDAO.getAllByDateTime(null);
    yield ReportsLoaded(player);
  }
}
