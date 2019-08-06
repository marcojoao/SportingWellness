import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';
import 'package:Wellness/services/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlayerCartesianChart extends StatelessWidget {
  PlayerCartesianChart(this.player, this.date);

  final Player player;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 20,
          minimum: -20,
          maximum: 120,
          visibleMinimum: 0,
          visibleMaximum: 100,
          rangePadding: ChartRangePadding.additional,
          labelFormat: '{value}%'),
      title: ChartTitle(
          text:
              "${AppLocalizations.translate('recoveryOver')} ${DateFormat('MMMM').format(date)}"),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <LineSeries<Report, String>>[
        LineSeries<Report, String>(
          name: AppLocalizations.translate('recovery'),
          color: Theme.of(context).accentColor,
          dataSource: player.reports,
          xValueMapper: (Report report, _) => report.dateTime.day.toString(),
          yValueMapper: (Report report, _) => report.recovery,
          markerSettings: MarkerSettings(color: Colors.white, isVisible: true),
        )
      ],
    );
  }
}
