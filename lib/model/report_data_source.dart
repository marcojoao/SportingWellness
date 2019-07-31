import 'package:Wellness/model/report.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportDataSource extends DataTableSource {
  int _selectedCount = 0;
  List<Report> _reports;

  ReportDataSource(this._reports);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _reports.length) return null;
    final Report report = _reports[index];
    var sorroness = report.sorroness
        ? EnumToString.parseCamelCase(report.sorronessSide)
        : "No info";
    var pain = report.pain
        ? EnumToString.parseCamelCase(report.painLocation)
        : 'No info';
    var painNumber = report.pain ? " | ${report.painNumber}" : "";

    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text(report.dateTime.day.toString())),
      DataCell(Text(EnumToString.parseCamelCase(report.sleepState))),
      DataCell(Text("${report.recovery}%")),
      DataCell(Text(sorroness)),
      DataCell(Text("${pain}${painNumber}")),
    ]);
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
  ];
}
