import 'package:flutter/material.dart';
import 'package:message/Page/AnimationPage.dart';
import 'package:message/Page/HomePage.dart';
import 'package:message/Page/LocalAuthenticationPage.dart';
import 'package:message/Page/LocalNotificationOptionPage.dart';
import 'package:message/Page/MultiTabPage.dart';
import 'package:message/Page/Public/AppLockPage.dart';
import 'package:message/Page/Public/IntroductionPage.dart';
import 'package:message/Page/Static/SettingPage.dart';
import 'package:message/Static/ListBuildItem/ListBottomNavigateItem.dart';
import 'package:message/Static/PageRouteName.dart';
import 'package:message/Template/BottomNavBarTemplate.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.homeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => HomePage(),
        );
      case PageRouteName.multiTabRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => MultiTabPage(),
        );
      case PageRouteName.animationRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => AnimationPage(),
        );
      case PageRouteName.notificationRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => LocalNotificationOptionPage(),
        );
      case PageRouteName.authenticationRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => LocalAuthenticationPage(),
        );
      case PageRouteName.settingRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => SettingPage(),
        );
      case PageRouteName.introductionRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => IntroductionPage(),
        );
      case PageRouteName.lockScreenRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => AppLockPage(),
        );
      case PageRouteName.createLockRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => AppLockPage(
            isSetupPasscode: true,
          ),
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
