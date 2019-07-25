import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sporting_performance/services/route_generator.dart';

void main() {
  //set device orientation,
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.green,
          accentColor: Colors.redAccent),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
