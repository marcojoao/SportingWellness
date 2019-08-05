import 'package:Wellness/model/report.dart';
import 'package:Wellness/services/app_localizations.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

class ReportDataSource extends DataTableSource {
  int _selectedCount = 0;
  List<Report> _reports;
  BuildContext _context;
  ReportDataSource(this._context, this._reports);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _reports.length) return null;
    final Report report = _reports[index];
    var sorroness = report.sorroness
        ? EnumToString.parseCamelCase(report.soronessLocation)
        : AppLocalizations.translate("noInfo");
    var sorronessSide = report.sorroness
        ? " (${EnumToString.parseCamelCase(report.sorronessSide)})"
        : "";
    var pain = report.pain
        ? EnumToString.parseCamelCase(report.painLocation)
        : AppLocalizations.translate("noInfo");
    var painNumber = report.pain ? " (${report.painNumber})" : "";

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(report.dateTime.day.toString())),
        DataCell(Text(EnumToString.parseCamelCase(report.sleepState))),
        DataCell(Text("${report.recovery}%")),
        DataCell(Text("$sorroness$sorronessSide")),
        DataCell(Text("$pain$painNumber")),
        DataCell(
          Icon(Icons.note,
              color: report.notes.length > 0
                  ? Theme.of(_context).accentColor
                  : Colors.grey),
          onTap: () => {
            if (report.notes.length > 0)
              _buildNoteViewer(_context, report.notes),
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
      label: Text(AppLocalizations.translate("day")),
      numeric: false,
    ),
    DataColumn(
      label: Text(AppLocalizations.translate("sleep")),
      numeric: false,
    ),
    DataColumn(
      label: Text(AppLocalizations.translate("recovery")),
      numeric: false,
    ),
    DataColumn(
      label: Text(AppLocalizations.translate("soreness")),
      numeric: false,
    ),
    DataColumn(
      label: Text(AppLocalizations.translate("pain")),
      numeric: false,
    ),
    DataColumn(
      label: Text(AppLocalizations.translate("note")),
      numeric: false,
    ),
  ];

  Future<void> _buildNoteViewer(BuildContext context, String msg) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    AppLocalizations.translate("reportNote"),
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                  child: SingleChildScrollView(
                    child: Text(
                      msg,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                    child: Text(
                      AppLocalizations.translate("close"),
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
