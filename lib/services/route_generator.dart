import 'package:Wellness/screens/dashboard.dart';
import 'package:Wellness/screens/player.dart';
import 'package:Wellness/screens/splash_page.dart';
import 'package:Wellness/services/app_localizations.dart';
import 'package:Wellness/tests/dashboard_mock.dart';
import 'package:flutter/material.dart';
import 'package:Wellness/model/player.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                SplashPage(nextPage: '/mockdashboard', introDuration: 3));
      case '/myhomepage':
        return _errorRoute(); //_getPageRoute(PlayerPage());
      case '/mockdashboard':
        return _getPageRoute(DashBoardMock());

      case '/addlistplayerstatus': //TODO: new player list / edit form
        if (args is Player) {
          return MaterialPageRoute(
            builder: (_) => Dashboard(),
          );
        }
        return _errorRoute();

      case '/playerdetail':
        if (args is Player) {
          return _getPageRoute(PlayerPage(args));
        }
        return _errorRoute();

      // return _getPageRoute(PlayerPage());
      case '/newplayer': //TODO: new player form
        return _errorRoute();
      case '/dashboard': //TODO: implement dashboard component
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLoc.getValue("error")),
        ),
        body: Center(
          child: Text(AppLoc.getValue("error").toUpperCase()),
        ),
      );
    });
  }

  static MaterialPageRoute<dynamic> _getPageRoute(Widget pageWidget) {
    return MaterialPageRoute(builder: (_) => pageWidget);
  }
}
