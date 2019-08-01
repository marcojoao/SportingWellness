import 'package:Wellness/model/report.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        : "No info";
    var sorronessSide = report.sorroness
        ? " | ${EnumToString.parseCamelCase(report.sorronessSide)}"
        : "";
    var pain = report.pain
        ? EnumToString.parseCamelCase(report.painLocation)
        : 'No info';
    var painNumber = report.pain ? " | ${report.painNumber}" : "";

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(report.dateTime.day.toString())),
        DataCell(Text(EnumToString.parseCamelCase(report.sleepState))),
        DataCell(Text("${report.recovery}%")),
        DataCell(Text("${sorroness}${sorronessSide}")),
        DataCell(Text("${pain}${painNumber}")),
        DataCell(
            Icon(Icons.note,
                color: report.notes.length > 0
                    ? Theme.of(_context).accentColor
                    : Colors.grey),
            onTap: () => {
                  if (report.notes.length > 0)
                    {
                      Fluttertoast.showToast(
                          msg: report.notes,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIos: 3),
                    }
                }),
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
      label: const Text('Day'),
      numeric: false,
    ),
    DataColumn(
      label: const Text('Sleep'),
      numeric: false,
    ),
    DataColumn(
      label: const Text('Recovery'),
      numeric: false,
    ),
    DataColumn(
      label: const Text('Soreness'),
      numeric: false,
    ),
    DataColumn(
      label: const Text('Pain'),
      numeric: false,
    ),
    DataColumn(
      label: const Text('Note'),
      numeric: false,
    ),
  ];
}
