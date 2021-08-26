import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message/Component/FirebaseMessageConfig.dart';
import 'package:message/Page/HomePage.dart';
import 'package:message/Page/LocalNotificationOptionPage.dart';
import 'package:message/Static/RouteGenerator.dart';
import 'Component/AnalyticsRouteObserver.dart';
import 'Event/InitEvent.dart';
import 'Page/Static/SplashPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FirebaseMessageConfig.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver firebaseObserver =
      FirebaseAnalyticsObserver(analytics: firebaseAnalytics);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          themeMode: ThemeMode.system,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: snapshot.connectionState == ConnectionState.waiting
              ? SplashPage()
              : MyHomePage(),
          navigatorObservers: [
            firebaseObserver,
            AnalyticsRouteObserver(analytics: firebaseAnalytics)
          ],
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}
