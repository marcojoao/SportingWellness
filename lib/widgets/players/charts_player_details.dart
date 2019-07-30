import 'dart:math';

import 'package:Wellness/model/report.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';

class LineChartPlayer extends StatefulWidget {
  final double heigth;
  final double width;
  final List<Report> reports;
  final isMonth;

  LineChartPlayer(
      {Key key, this.heigth, this.width, this.reports, this.isMonth})
      : super(key: key);

  _LineChartPlayerState createState() => _LineChartPlayerState();
}

class _LineChartPlayerState extends State<LineChartPlayer> {
  final List<DateTime> monthDays = Utils.daysInMonth(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    List<DateTime> monthDays1 = widget.isMonth
        ? Utils.daysInMonth(date)
        : Utils.daysInRange(
                Utils.firstDayOfWeek(date), Utils.lastDayOfWeek(date))
            .toList();
    var days = monthDays1.map((x) => x.day.toDouble()).toSet().toList();
    days.sort();
    print(days);
    var data = days
        .map((f) => DataPoint<double>(value: Random().nextDouble(), xAxis: f))
        .toList(); //TODO: get values from Reports
    return Container(
      child: BezierChart(
        bezierChartScale: BezierChartScale.CUSTOM,
        xAxisCustomValues: days, //const [0, 5, 10, 15, 20, 25, 30, 35],
        series: [
          BezierLine(label: "andy", data: data),
        ],
        config: BezierChartConfig(
          pinchZoom: false,
          startYAxisFromNonZeroValue: false,
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          backgroundColor: Colors.red,
          snap: false,
          bubbleIndicatorColor: Colors.white.withOpacity(0.9),
          backgroundGradient: LinearGradient(
            colors: [
              Colors.red[100],
              Colors.red[400],
              Colors.red[400],
              Colors.red[500],
              Colors.red,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );

    // verticalBarChart, lineChart
  }
}
