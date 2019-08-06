import 'package:flutter/material.dart';

class Themes {
  
  static Color lightPrimary = Colors.grey[200];
  static Color darkPrimary = Colors.grey[600];

  static Color lightAccent = Colors.green;
  static Color darkAccent = Colors.green;
  
  static Color badgeColor = Colors.red;

  static Brightness lightBrightness = Brightness.light;
  static Brightness darkBrightness = Brightness.dark;

  static ThemeData lightTheme = ThemeData(
    brightness: lightBrightness,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: darkBrightness,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    cursorColor: darkAccent,
  );
}