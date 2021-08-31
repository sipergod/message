import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationInitSettings {
  ApplicationInitSettings._();
  static final instance = ApplicationInitSettings._();

  late SharedPreferences sharedPreferences;
  bool themeIsSystem = false;
  bool themeIsDark = false;

  static FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver firebaseObserver =
      FirebaseAnalyticsObserver(analytics: firebaseAnalytics);
}
