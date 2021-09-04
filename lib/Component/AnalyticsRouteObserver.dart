import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:message/Static/ApplicationInitSettings.dart';

class AnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final FirebaseAnalytics analytics;

  AnalyticsRouteObserver({required this.analytics});

  void sendPageView(PageRoute<dynamic> route) {
    String? pageName = route.settings.name;
    ApplicationInitSettings.instance.currentPageName = pageName!;
    analytics.setCurrentScreen(screenName: pageName);

    print('pageName: $pageName');
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      sendPageView(route);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      sendPageView(newRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      sendPageView(previousRoute);
    }
  }
}
