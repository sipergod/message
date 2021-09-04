import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message/Page/HomePage.dart';
import 'package:message/Page/Public/AppLockPage.dart';
import 'package:message/Static/RouteGenerator.dart';
import 'Component/AnalyticsRouteObserver.dart';
import 'Event/InitEvent.dart';
import 'Page/Public/IntroductionPage.dart';
import 'Static/AppThemes.dart';
import 'Static/ApplicationInitSettings.dart';
import 'Static/PageRouteName.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Init.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.grey[800],
      ),
    );

    return DynamicTheme(
      themeCollection: themeCollection,
      defaultThemeId: ApplicationInitSettings.instance.themeIsDark
          ? AppThemes.Dark
          : AppThemes.Light,
      builder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          theme: theme,
          home: buildHome(),
          navigatorObservers: [
            ApplicationInitSettings.firebaseObserver,
            AnalyticsRouteObserver(
              analytics: ApplicationInitSettings.firebaseAnalytics,
            ),
          ],
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }

  Widget buildHome() {
    if (ApplicationInitSettings.instance.sharedPreferences.getBool('Welcome') ==
        null) {
      ApplicationInitSettings.instance.currentPageName = PageRouteName.introductionRoute;
      return IntroductionPage();
    }
    if (Init.instance.checkForLockingApp()) {
      ApplicationInitSettings.instance.currentPageName = PageRouteName.lockScreenRoute;
      return AppLockPage();
    }
    ApplicationInitSettings.instance.currentPageName = PageRouteName.homeRoute;
    return HomePage();
  }
}
