import 'package:Wellness/blocs/report_bloc/report_bloc.dart';
import 'package:Wellness/blocs/report_bloc/report_event.dart';
import 'package:Wellness/blocs/report_bloc/report_state.dart';
import 'package:Wellness/model/dao/report_dao.dart';
import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';
import 'package:Wellness/services/app_localizations.dart';
import 'package:Wellness/widgets/report/report_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PlayerReportDatatable extends StatefulWidget {
  Player player;
  DateTime date;
  int reportPerPage;
  PlayerReportDatatable(this.player, this.date, this.reportPerPage);

  _PlayerReportDatatableState createState() => _PlayerReportDatatableState();
}

class _PlayerReportDatatableState extends State<PlayerReportDatatable> {
  //PlayerReportDatatable(this.player, this.date, this.reportPerPage);
  // ReportBloc _reportBloc;
  ReportDAO repoDAO = ReportDAO();
  @override
  void initState() {
    super.initState();

    // _reportBloc = BlocProvider.of<ReportBloc>(context);
    // //PlayerCartesianChart( this.widget.player , this.widget.date);

    // _reportBloc.dispatch(LoadReports());
  }

  @override
  Widget build(BuildContext context) {
    final ReportBloc reportBloc = BlocProvider.of<ReportBloc>(context);
    return BlocBuilder(
        bloc: reportBloc,
        builder: (BuildContext context, ReportState state) {
          if (state is ReportsLoaded) {
            PaginatedDataTable(
              rowsPerPage: (state.reports.length < widget.reportPerPage)
                  ? state.reports.length
                  : widget.reportPerPage,
              columnSpacing: 40,
              header: Text(
                  '${AppLoc.getValue('reportsOver')} ${DateFormat('MMMM').format(widget.date)}'),
              columns: ReportDataSource.getDataColumn,
              source: ReportDataSource(context, state.reports),
            );
          } else
            return Center(
              child: new CircularProgressIndicator(strokeWidth: 5.0),
            );
        });
  }

  @override
  Widget build1(BuildContext context) {
    return FutureBuilder(
        future: repoDAO.getAllById(1),
        builder: (BuildContext context, AsyncSnapshot<List<Report>> snapshot) {
          return snapshot.hasData
              ? PaginatedDataTable(
                  rowsPerPage: (snapshot.data.length < widget.reportPerPage)
                      ? snapshot.data.length
                      : widget.reportPerPage,
                  columnSpacing: 40,
                  header: Text(
                      '${AppLoc.getValue('reportsOver')} ${DateFormat('MMMM').format(widget.date)}'),
                  columns: ReportDataSource.getDataColumn,
                  source: ReportDataSource(context, snapshot.data),
                )
              : CircularProgressIndicator();
        });
  }
}
