import 'dart:io';

import 'package:Wellness/services/app_localizations.dart';
import 'package:Wellness/utils/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Wellness/services/route_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_offline/flutter_offline.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  _setTargetPlatformForDesktop();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          return Container(
            child: Column(
              children: <Widget>[
                _buildConnectionWarning(context, connectivity),
                _buildMaterialApp(false),
              ],
            ),
          );
        },
        child: Container());
  }
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

Widget _buildConnectionWarning(
    BuildContext context, ConnectivityResult connectivity) {
  if (connectivity != ConnectivityResult.none) return Container();
  return Container(
    alignment: Alignment.center,
    color: Colors.red,
    height: 32,
    child: new Directionality(
      textDirection: TextDirection.ltr,
      child: new Text('Offline'),
    ),
  );
}

Widget _buildMaterialApp(bool useDarkTheme) {

  return Expanded(
    child: MaterialApp(
      supportedLocales: AppLoc.supportedLocales,
      localizationsDelegates: [
        AppLoc.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // ! For now only english
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales)
          if (supportedLocale == locale) return supportedLocale;
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      theme: useDarkTheme ? Themes.darkTheme : Themes.lightTheme,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
  );
}