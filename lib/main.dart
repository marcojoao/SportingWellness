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

import 'package:Wellness/widgets/players/FloatingActionButton_Extended.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _MyHomePageState extends State<MyHomePage>  {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton:  FloatingActionButton_Extended(context),
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
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              color: Theme.of(context).accentColor),
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
                                  children: ListTile.divideTiles(
                                    context: context,
                                    tiles: [
                                      ListTile(
                                          title: Text('Sun'),
                                          leading: Icon(Icons.wb_sunny)),
                                      ListTile(
                                          title: Text('Moon'),
                                          leading: Icon(Icons.brightness_3)),
                                      ListTile(
                                          title: Text('Star'),
                                          leading: Icon(Icons.star)),
                                      ListTile(
                                          title: Text('Sun'),
                                          leading: Icon(Icons.wb_sunny)),
                                      ListTile(
                                          title: Text('Moon'),
                                          leading: Icon(Icons.brightness_3)),
                                      ListTile(
                                          title: Text('Star'),
                                          leading: Icon(Icons.star)),
                                      ListTile(
                                          title: Text('Sun'),
                                          leading: Icon(Icons.wb_sunny)),
                                      ListTile(
                                          title: Text('Moon'),
                                          leading: Icon(Icons.brightness_3)),
                                      ListTile(
                                          title: Text('Star'),
                                          leading: Icon(Icons.star)),
                                      ListTile(
                                          title: Text('Sun'),
                                          leading: Icon(Icons.wb_sunny)),
                                      ListTile(
                                          title: Text('Moon'),
                                          leading: Icon(Icons.brightness_3)),
                                      ListTile(
                                          title: Text('Star'),
                                          leading: Icon(Icons.star)),
                                      ListTile(
                                          title: Text('Sun'),
                                          leading: Icon(Icons.wb_sunny)),
                                      ListTile(
                                          title: Text('Moon'),
                                          leading: Icon(Icons.brightness_3)),
                                      ListTile(
                                          title: Text('Star'),
                                          leading: Icon(Icons.star)),
                                      ListTile(
                                          title: Text('Sun'),
                                          leading: Icon(Icons.wb_sunny)),
                                      ListTile(
                                          title: Text('Moon'),
                                          leading: Icon(Icons.brightness_3)),
                                      ListTile(
                                          title: Text('Star'),
                                          leading: Icon(Icons.star)),
                                      ListTile(
                                          title: Text('Sun'),
                                          leading: Icon(Icons.wb_sunny)),
                                      ListTile(
                                          title: Text('Moon'),
                                          leading: Icon(Icons.brightness_3)),
                                      ListTile(
                                          title: Text('Star'),
                                          leading: Icon(Icons.star)),
                                    ],
                                  ).toList(),
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
