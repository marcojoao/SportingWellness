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

import 'package:Wellness/widgets/general/floating_action_menu.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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
                          //color: Theme.of(context).accentColor,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Theme.of(context).accentColor),
                          child: chartExample(context),
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

Widget chartExample(BuildContext context) {

  final toDate = DateTime.now();
  final fromDate = DateTime(toDate.year-1, toDate.month, toDate.day);

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
  
  final toDate = DateTime.now();
  final fromDate = DateTime(toDate.year-1, toDate.month, toDate.day);

  final date1 = DateTime.now().subtract(Duration(days: 2));
  final date2 = DateTime.now().subtract(Duration(days: 3));

  final date3 = DateTime.now().subtract(Duration(days: 300));
  final date4 = DateTime.now().subtract(Duration(days: 320));

  final date5 = DateTime.now().subtract(Duration(days: 650));
  final date6 = DateTime.now().subtract(Duration(days: 652));

  return Center(
    child: BezierChart(
      bezierChartScale: BezierChartScale.YEARLY,
      fromDate: fromDate,
      toDate: toDate,
      selectedDate: toDate,
      series: [
        BezierLine(
          label: "Duty",
          onMissingValue: (dateTime) {
            if (dateTime.year.isEven) {
              return 20.0;
            }
            return 5.0;
          },
          data: [
            DataPoint<DateTime>(value: 10, xAxis: date1),
            DataPoint<DateTime>(value: 50, xAxis: date2),
            DataPoint<DateTime>(value: 100, xAxis: date3),
            DataPoint<DateTime>(value: 100, xAxis: date4),
            DataPoint<DateTime>(value: 40, xAxis: date5),
            DataPoint<DateTime>(value: 47, xAxis: date6),
          ],
        ),
        BezierLine(
          label: "Flight",
          lineColor: Colors.black26,
          onMissingValue: (dateTime) {
            if (dateTime.month.isEven) {
              return 10.0;
            }
            return 3.0;
          },
          data: [
            DataPoint<DateTime>(value: 20, xAxis: date1),
            DataPoint<DateTime>(value: 30, xAxis: date2),
            DataPoint<DateTime>(value: 150, xAxis: date3),
            DataPoint<DateTime>(value: 80, xAxis: date4),
            DataPoint<DateTime>(value: 45, xAxis: date5),
            DataPoint<DateTime>(value: 45, xAxis: date6),
          ],
        ),
      ],
      config: BezierChartConfig(
        verticalIndicatorStrokeWidth: 3.0,
        verticalIndicatorColor: Colors.black26,
        showVerticalIndicator: false,
        verticalIndicatorFixedPosition: false,
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
