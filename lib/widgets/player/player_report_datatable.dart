import 'package:Wellness/model/player.dart';
import 'package:Wellness/services/app_localizations.dart';
import 'package:Wellness/widgets/report/report_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayerReportDatatable extends StatelessWidget {
  PlayerReportDatatable(this.player, this.date, this.reportPerPage);

  final Player player;
  final DateTime date;
  final int reportPerPage;

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      rowsPerPage: (player.reports.length < reportPerPage)
          ? player.reports.length : reportPerPage,
      columnSpacing: 40,
      header: Text('${AppLocalizations.translate('reportsOver')} ${DateFormat('MMMM').format(date)}'),
      columns: ReportDataSource.getDataColumn,
      source: ReportDataSource(context, player.reports),
    );
  }
}
