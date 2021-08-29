import 'package:flutter/material.dart';

class ListBottomNavigateItem {
  static List<Map<String, dynamic>> list = [
    {
      'icon': Icon(Icons.home),
      'tooltip': 'Home',
      'pageName': '/',
    },
    {
      'icon': Icon(Icons.table_view),
      'tooltip': 'Multiple Tab Page',
      'pageName': '/multiTab',
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
}
