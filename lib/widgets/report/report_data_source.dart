import 'package:Wellness/model/report.dart';
import 'package:Wellness/services/app_localizations.dart';
import 'package:Wellness/utils/general.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

class ReportDataSource extends DataTableSource {
  int _selectedCount = 0;
  List<Report> _reports;
  BuildContext context;
  ReportDataSource(this.context, this._reports);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _reports.length) return null;
    final Report report = _reports[index];
    var sleepState =
        AppLoc.getValue(EnumToString.parse(report.sleepState));
    var sorroness = report.sorroness
        ? AppLoc.getValue(
            EnumToString.parse(report.soronessLocation))
        : AppLoc.getValue("noInfo");
    var sorronessSide = report.sorroness
        ? " (${AppLoc.getValue(EnumToString.parse(report.sorronessSide))})"
        : "";
    var pain = report.pain
        ? AppLoc.getValue(EnumToString.parse(report.painLocation))
        : AppLoc.getValue("noInfo");
    var painNumber = report.pain ? " (${report.painNumber})" : "";

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(report.dateTime.day.toString())),
        DataCell(Text(sleepState)),
        DataCell(Text("${report.recovery}%")),
        DataCell(Text("$sorroness$sorronessSide")),
        DataCell(Text("$pain$painNumber")),
        DataCell(
          Icon(Icons.note,
              color: report.notes.length > 0
                  ? Theme.of(context).accentColor
                  : Colors.grey),
          onTap: () => {
            if (report.notes.length > 0)
              showMessageDialog(
                context,
                AppLoc.getValue("reportNote"),
                Text(
                  report.notes,
                  style: TextStyle(fontSize: 12.0),
                ),
              )
          },
        ),
      ],
    );
  }

  @override
  int get rowCount => _reports.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  static List<DataColumn> getDataColumn = <DataColumn>[
    DataColumn(
      label: Text(AppLoc.getValue("day")),
      numeric: false,
    ),
    DataColumn(
      label: Text(AppLoc.getValue("sleep")),
      numeric: false,
    ),
    DataColumn(
      label: Text(AppLoc.getValue("recovery")),
      numeric: false,
    ),
    DataColumn(
      label: Text(AppLoc.getValue("soreness")),
      numeric: false,
    ),
    DataColumn(
      label: Text(AppLoc.getValue("pain")),
      numeric: false,
    ),
    DataColumn(
      label: Text(AppLoc.getValue("note")),
      numeric: false,
    ),
  ];
}
