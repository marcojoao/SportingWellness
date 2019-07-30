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
    

    // var days = monthDays.map((x) => x.day.toDouble()).toSet().toList();
    // days.sort();
    // print(days);
    // var data = days
    //     .map((f) => DataPoint<DateTime>(value: 10, xAxis: f.))
    //     .toList(); //TODO: get values from Reports
  
    // return Center(
    //   child: Container(
    //     color: Colors.red,
    //     height: widget.heigth, //MediaQuery.of(context).size.height / 2,
    //     width: widget.width, //MediaQuery.of(context).size.width * 0.9,
    //     child: BezierChart(
    //       bezierChartScale: BezierChartScale.CUSTOM,
    //       xAxisCustomValues: days, //const [0, 5, 10, 15, 20, 25, 30, 35],
    //       series: [
    //         BezierLine(data: data),
    //       ],
    //       config: BezierChartConfig(
    //         verticalIndicatorStrokeWidth: 3.0,
    //         verticalIndicatorColor: Colors.black26,
    //         showVerticalIndicator: true,
    //         backgroundColor: Colors.red,
    //         snap: false,
    //       ),
    //     ),
    //   ),
    // );

    // // verticalBarChart, lineChart


   

    final toDate = DateTime.now();
    final fromDate = DateTime(toDate.year - 1, toDate.month, toDate.day);

    //Suggestion
    //var data = widget?.reports?.map((f) => DataPoint<DateTime>(value: f.recovery, xAxis: f.dateTime)).toList(); //TODO: get values from Reports

    final date1 = DateTime.now().subtract(Duration(days: 2));
    final date2 = DateTime.now().subtract(Duration(days: 3));

    final date3 = DateTime.now().subtract(Duration(days: 35));
    final date4 = DateTime.now().subtract(Duration(days: 36));

    final date5 = DateTime.now().subtract(Duration(days: 65));
    final date6 = DateTime.now().subtract(Duration(days: 64));

    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          bezierChartScale: BezierChartScale.MONTHLY,
          fromDate: fromDate,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              label: "Report",
              onMissingValue: (dateTime) {
                return 0;
              },
              data: [
                DataPoint<DateTime>(value: 10, xAxis: date1),
                DataPoint<DateTime>(value: 50, xAxis: date2),
                DataPoint<DateTime>(value: 20, xAxis: date3),
                DataPoint<DateTime>(value: 80, xAxis: date4),
                DataPoint<DateTime>(value: 14, xAxis: date5),
                DataPoint<DateTime>(value: 30, xAxis: date6),
              ],
            ),
          ],
          config: BezierChartConfig(
            
            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            backgroundColor: Colors.red[300],
            footerHeight: 50,
          ),
        ),
      ),
    );
  }


}
