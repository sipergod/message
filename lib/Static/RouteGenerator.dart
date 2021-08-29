import 'package:flutter/material.dart';
import 'package:message/Page/HomePage.dart';
import 'package:message/Page/LocalAuthenticationPage.dart';
import 'package:message/Page/LocalNotificationOptionPage.dart';
import 'package:message/Page/MuiltiTabPage.dart';
import 'package:message/Static/ListBuildItem/ListBottomNavigateItem.dart';
import 'package:message/Template/BottomNavBarTemplate.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => MyHomePage(),
        );
      case '/multiTab':
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => MultiTabPage(),
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
            listBottomNavigateBar: ListBottomNavigateItem.list,
            bottomNavigateBarIndex: 5,
          );
        });
  }

  static createRoute(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
