import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Wellness/services/route_generator.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  _setTargetPlatformForDesktop();
  return runApp(MyApp());
}

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _getThemeDate(false),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

ThemeData _getThemeDate(bool useDark) {
  var lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey[200],
    accentColor: Colors.green,
  );

  var darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[600],
    accentColor: Colors.green,
  );
  return useDark ? darkTheme : lightTheme;
}
