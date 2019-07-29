import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';

class LineChartPlayer extends StatefulWidget {
  final double heigth;
  final double width;

  LineChartPlayer({Key key, this.heigth, this.width}) : super(key: key);

  _LineChartPlayerState createState() => _LineChartPlayerState();
}

class _LineChartPlayerState extends State<LineChartPlayer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        height: widget.heigth, //MediaQuery.of(context).size.height / 2,
        width: widget.width, //MediaQuery.of(context).size.width * 0.9,
        child: BezierChart(
          bezierChartScale: BezierChartScale.CUSTOM,
          xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
          series: const [
            BezierLine(
              data: const [
                DataPoint<double>(value: 10, xAxis: 0),
                DataPoint<double>(value: 130, xAxis: 5),
                DataPoint<double>(value: 50, xAxis: 10),
                DataPoint<double>(value: 150, xAxis: 15),
                DataPoint<double>(value: 75, xAxis: 20),
                DataPoint<double>(value: 0, xAxis: 25),
                DataPoint<double>(value: 5, xAxis: 30),
                DataPoint<double>(value: 45, xAxis: 35),
              ],
            ),
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
