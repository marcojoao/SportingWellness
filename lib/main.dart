// // import 'dart:io';

// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:Wellness/services/route_generator.dart';

// // void main() {
// //   //set device orientation,
// //   SystemChrome.setEnabledSystemUIOverlays([]);
// //   SystemChrome.setPreferredOrientations(
// //       [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
// //   _setTargetPlatformForDesktop();
// //   return runApp(MyApp());
// // }

// // void _setTargetPlatformForDesktop() {
// //   TargetPlatform targetPlatform;
// //   if (Platform.isMacOS) {
// //     targetPlatform = TargetPlatform.iOS;
// //   } else if (Platform.isLinux || Platform.isWindows) {
// //     targetPlatform = TargetPlatform.android;
// //   }
// //   if (targetPlatform != null) {
// //     debugDefaultTargetPlatformOverride = targetPlatform;
// //   }
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //           brightness: Brightness.light,
// //           primarySwatch: Colors.green,
// //           accentColor: Colors.redAccent),
// //       initialRoute: '/',
// //       onGenerateRoute: RouteGenerator.generateRoute,
// //     );
// //   }
// // }

import 'dart:math';

import 'package:Wellness/widgets/general/floating_action_menu.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'model/report.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Wellness',
      theme: new ThemeData(
        primaryColor: Colors.grey[300],
        accentColor: Colors.green,
        brightness: Brightness.light,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static double buttonElevation = 4;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionMenu(
        context,
        closedColor: Theme.of(context).accentColor,
        children: [
          Container(
            child: FloatingActionButton(
                mini: true,
                onPressed: () => {
                      Fluttertoast.showToast(
                          msg: "Add Report",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIos: 1),
                    },
                tooltip: 'Add Report',
                backgroundColor: Theme.of(context).cardColor,
                child: Icon(Icons.add, color: Theme.of(context).accentColor)),
          ),
          Container(
            child: FloatingActionButton(
                mini: true,
                onPressed: () => {
                      Fluttertoast.showToast(
                          msg: "Edit Profile",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIos: 1),
                    },
                tooltip: 'Edit Profile',
                backgroundColor: Theme.of(context).cardColor,
                child: Icon(Icons.edit, color: Theme.of(context).accentColor)),
          ),
        ],
      ),
      body: new Container(
        child: new Row(
          children: <Widget>[
            new Container(
              color: Theme.of(context).primaryColor,
              width: 200,
            ),
            new Expanded(
              child: new Container(
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 5),
                      child: new Card(
                        child: new Container(
                          margin: EdgeInsets.all(10),
                          child: chartExample2(context),
                        ),
                      ),
                      alignment: Alignment.center,
                      height: 250,
                    ),
                    new Expanded(
                      child: new Container(
                        margin: EdgeInsets.only(
                            top: 5, left: 10, right: 10, bottom: 10),
                        child: new Card(
                          child: new Container(
                            child: Scrollbar(
                              child: LiquidPullToRefresh(
                                child: ListView(
                                  children: listTileExamples(context),
                                ),
                                onRefresh: () async {}, // scroll view
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Report> randomReports() {
  List<Report> report = new List<Report>();
  Random rng = new Random();
  var playerId = rng.nextInt(1000);
  for (var i = 1; i <= 12; i++) {
    report.add(
      Report(
        playerId: playerId,
        dateTime: DateTime.utc(2019, i, 1),
        sleepState: SleepState.values[rng.nextInt(SleepState.values.length)],
        recovery: (rng.nextDouble() * 100).round() * 1.0,
        sorroness: true,
        soronessLocation:
            BodyLocation.values[rng.nextInt(BodyLocation.values.length)],
        sorronessSide: BodySide.values[rng.nextInt(BodySide.values.length)],
        pain: true,
        painLocation:
            BodyLocation.values[rng.nextInt(BodyLocation.values.length)],
        painSide: BodySide.values[rng.nextInt(BodySide.values.length)],
        painNumber: rng.nextInt(10),
      ),
    );
  }
  return report;
}

Widget chartExample2(BuildContext context) {
  return SfCartesianChart(
    primaryXAxis: CategoryAxis(),
    primaryYAxis: NumericAxis(
      edgeLabelPlacement: EdgeLabelPlacement.hide,
      interval: 20,
      minimum: -20,
      maximum: 120,
      visibleMinimum: 0,
      visibleMaximum: 100,
      rangePadding: ChartRangePadding.additional,
    ),
    //legend: Legend(isVisible: true),
    // Chart title
    title: ChartTitle(text: "Player Recovery over ${DateTime.now().year}"),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <LineSeries<Report, String>>[
      LineSeries<Report, String>(
        color: Theme.of(context).accentColor,
        dataSource: randomReports(),
        xValueMapper: (Report report, _) => report.dateTime.month.toString(),
        yValueMapper: (Report report, _) => report.recovery,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
        ),
      )
    ],
  );
}

Widget chartExample(BuildContext context) {
  final toDate = DateTime.now();
  final fromDate = DateTime(toDate.year - 1, toDate.month, toDate.day);

  final date1 = DateTime.now().subtract(Duration(days: 2));
  final date2 = DateTime.now().subtract(Duration(days: 3));

  final date3 = DateTime.now().subtract(Duration(days: 35));
  final date4 = DateTime.now().subtract(Duration(days: 36));

  final date5 = DateTime.now().subtract(Duration(days: 65));
  final date6 = DateTime.now().subtract(Duration(days: 64));

  return Center(
    child: BezierChart(
      bezierChartScale: BezierChartScale.MONTHLY,
      fromDate: fromDate,
      toDate: toDate,
      selectedDate: toDate,
      series: [
        BezierLine(
          label: "Duty",
          onMissingValue: (dateTime) {
            if (dateTime.month.isEven) {
              return 10.0;
            }
            return 5.0;
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
        footerHeight: 30.0,
      ),
    ),
  );
}

List<Widget> listTileExamples(BuildContext context) {
  return ListTile.divideTiles(
    context: context,
    tiles: [
      ListTile(title: Text('Sun'), leading: Icon(Icons.wb_sunny)),
      ListTile(title: Text('Moon'), leading: Icon(Icons.brightness_3)),
      ListTile(title: Text('Star'), leading: Icon(Icons.star)),
      ListTile(title: Text('Sun'), leading: Icon(Icons.wb_sunny)),
      ListTile(title: Text('Moon'), leading: Icon(Icons.brightness_3)),
      ListTile(title: Text('Star'), leading: Icon(Icons.star)),
      ListTile(title: Text('Sun'), leading: Icon(Icons.wb_sunny)),
      ListTile(title: Text('Moon'), leading: Icon(Icons.brightness_3)),
      ListTile(title: Text('Star'), leading: Icon(Icons.star)),
      ListTile(title: Text('Sun'), leading: Icon(Icons.wb_sunny)),
      ListTile(title: Text('Moon'), leading: Icon(Icons.brightness_3)),
      ListTile(title: Text('Star'), leading: Icon(Icons.star)),
      ListTile(title: Text('Sun'), leading: Icon(Icons.wb_sunny)),
      ListTile(title: Text('Moon'), leading: Icon(Icons.brightness_3)),
      ListTile(title: Text('Star'), leading: Icon(Icons.star)),
      ListTile(title: Text('Sun'), leading: Icon(Icons.wb_sunny)),
      ListTile(title: Text('Moon'), leading: Icon(Icons.brightness_3)),
      ListTile(title: Text('Star'), leading: Icon(Icons.star)),
      ListTile(title: Text('Sun'), leading: Icon(Icons.wb_sunny)),
      ListTile(title: Text('Moon'), leading: Icon(Icons.brightness_3)),
      ListTile(title: Text('Star'), leading: Icon(Icons.star)),
    ],
  ).toList();
}
