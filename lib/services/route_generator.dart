import 'package:flutter/material.dart';
import 'package:sporting_performance/model/player.dart';
import 'package:sporting_performance/widgets/my_homepage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'player',
                ));

      case '/addlistplayerstatus': //TODO: new player list / edit form
        if (args is Player) {
          return MaterialPageRoute(
            builder: (_) => MyHomePage(
              title: 'Secondpage',
            ),
          );
        }

        return _errorRoute();

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
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
