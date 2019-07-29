import 'dart:math';

import 'package:Wellness/model/report.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';

class LineChartPlayer extends StatefulWidget {
  final double heigth;
  final double width;
  final List<Report> reports;

  LineChartPlayer({Key key, this.heigth, this.width, this.reports})
      : super(key: key);

  _LineChartPlayerState createState() => _LineChartPlayerState();
}

class _LineChartPlayerState extends State<LineChartPlayer> {
  final List<DateTime> monthDays = Utils.daysInMonth(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var days = monthDays.map((x) => x.day.toDouble()).toSet().toList();
    days.sort();
    print(days);
    var data = days
        .map((f) => DataPoint<double>(value: 10, xAxis: f))
        .toList(); //TODO: get values from Reports
    return Center(
      child: Container(
        color: Colors.red,
        height: widget.heigth, //MediaQuery.of(context).size.height / 2,
        width: widget.width, //MediaQuery.of(context).size.width * 0.9,
        child: BezierChart(
          bezierChartScale: BezierChartScale.CUSTOM,
          xAxisCustomValues: days, //const [0, 5, 10, 15, 20, 25, 30, 35],
          series: [
            BezierLine(data: data),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            backgroundColor: Colors.red,
            snap: false,
          ),
        ),
      ),
    );

    // verticalBarChart, lineChart
  }
}
