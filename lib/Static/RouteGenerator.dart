import 'package:flutter/material.dart';
import 'package:message/Page/HomePage.dart';
import 'package:message/Page/LocalAuthenticationPage.dart';
import 'package:message/Page/LocalNotificationOptionPage.dart';
import 'package:message/Template/BottomNavBarTemplate.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => MyHomePage(),
        );
      case '/notification':
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => LocalNotificationOptionPage(),
        );
      case '/authentication':
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => LocalAuthenticationPage(),
        );
      default:
        return _errorRoute(settings);
    }
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) {
          return BottomNavBarTemplate(
            title: 'Error',
            bodyWidget: Center(
              child: Text('ERROR'),
            ),
          );
        });
  }
}
