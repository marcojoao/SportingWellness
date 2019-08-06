import 'dart:async';
import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppLoc {
  final Locale locale;
  AppLoc(this.locale);
  static Map<String, String> _localizedStrings;

  static final List<Locale> supportedLocales = [Locale('en', 'US')/*, Locale('pt', 'PT')*/];

  static const LocalizationsDelegate<AppLoc> delegate = _AppLocalizationsDelegate();

  static AppLoc of(BuildContext context) {
    return Localizations.of<AppLoc>(context, AppLoc);
  }
  
  static String getValue(String key) {
    var result = _localizedStrings[key];
    if(result == null){
      print("Warning: [$key] dont exist");
      return "[NULL]";
    }
    return _localizedStrings[key];
  }

  Future load() async {
    String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map(
      (key, value) {
        return MapEntry(key, value.toString());
      },
    );
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLoc> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLoc.supportedLocales.contains(locale);
  }

  @override
  Future<AppLoc> load(Locale locale) async {
    AppLoc localizations = new AppLoc(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLoc> old) {
    return false;
  }
}
