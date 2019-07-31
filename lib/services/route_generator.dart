import 'package:Wellness/widgets/players/player_detail_container_debug.dart';
import 'package:flutter/material.dart';
import 'package:Wellness/widgets/players/player_detail_container.dart';
import 'package:Wellness/widgets/splash_page.dart';
import 'package:Wellness/model/player.dart';
import 'package:Wellness/widgets/my_homepage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                SplashPage(nextPage: '/playerdetail', introDuration: 3));
      case '/myhomepage':
      return MaterialPageRoute(builder: (_) => PlayerDetailContainer());

      case '/addlistplayerstatus': //TODO: new player list / edit form
        if (args is Player) {
          return MaterialPageRoute(
            builder: (_) => MyHomePage(
              title: 'Secondpage',
            ),
          );
        }
        return _errorRoute();

      case '/playerdetail':
        return _getPageRoute(PlayerDetailContainerDebug());
        //return _getPageRoute(PlayerDetailContainer());
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

  static MaterialPageRoute<dynamic> _getPageRoute(Widget pageWidget) {
    return MaterialPageRoute(builder: (_) => pageWidget);
  }
}
