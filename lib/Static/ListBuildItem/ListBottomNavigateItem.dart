import 'package:flutter/material.dart';

import '../PageRouteName.dart';

class ListBottomNavigateItem {
  static List<Map<String, dynamic>> list = [
    {
      'icon': Icon(Icons.home),
      'tooltip': 'Home',
      'pageName': PageRouteName.homeRoute,
    },
    {
      'icon': Icon(Icons.table_view),
      'tooltip': 'Multiple Tab Page',
      'pageName': PageRouteName.multiTabRoute,
    },
    {
      'icon': Icon(Icons.animation),
      'tooltip': 'Animation Page',
      'pageName': PageRouteName.animationRoute,
    },
    {},
    {
      'icon': Icon(Icons.notification_important_rounded),
      'tooltip': 'Notification',
      'pageName': '/notification',
    },
    {
      'icon': Icon(Icons.fingerprint),
      'tooltip': 'Authentication',
      'pageName': PageRouteName.authenticationRoute,
    },
    {
      'icon': Icon(Icons.settings),
      'tooltip': 'Settings',
      'pageName': PageRouteName.settingRoute,
    },
  ];

  static const int homeIndex = 0;
  static const int multiTabIndex = 1;
  static const int animationIndex = 2;
  static const int notificationIndex = 4;
  static const int authenticationIndex = 5;
  static const int settingIndex = 6;
}
