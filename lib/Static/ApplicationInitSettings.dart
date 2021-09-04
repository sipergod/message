import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationInitSettings {
  ApplicationInitSettings._();
  static final instance = ApplicationInitSettings._();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  late State state;
  DateTime? currentBackPressTime;
  String currentPageName = '';

  late SharedPreferences sharedPreferences;
  String appPasscode = '';
  int appPasscodeLength = 0;
  bool themeIsSystem = false;
  bool themeIsDark = false;

  static FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver firebaseObserver =
      FirebaseAnalyticsObserver(analytics: firebaseAnalytics);
}
