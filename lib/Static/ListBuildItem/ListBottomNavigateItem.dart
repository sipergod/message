import 'package:flutter/material.dart';

class ListBottomNavigateItem {
  static List<Map<String, dynamic>> list = [
    {
      'icon': Icon(Icons.home),
      'tooltip': 'Home',
      'pageName': '/home',
    },
    {
      'icon': Icon(Icons.table_view),
      'tooltip': 'Multiple Tab Page',
      'pageName': '/multiTab',
    },
    {
      'icon': Icon(Icons.animation),
      'tooltip': 'Animation Page',
      'pageName': '/animation',
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
      'pageName': '/authentication',
    },
    {
      'icon': Icon(Icons.settings),
      'tooltip': 'Settings',
      'pageName': '/setting',
    },
  ];

  static const int homeIndex = 0;
  static const int multiTabIndex = 1;
  static const int animationIndex = 2;
  static const int notificationIndex = 4;
  static const int authenticationIndex = 5;
  static const int settingIndex = 6;
}
