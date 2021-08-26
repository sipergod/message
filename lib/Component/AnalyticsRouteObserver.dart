import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final FirebaseAnalytics analytics;

  AnalyticsRouteObserver({required this.analytics});

  void _sendPageView(PageRoute<dynamic> route) {
    String? pageName = route.settings.name;
    analytics.setCurrentScreen(screenName: pageName);

    print('pageName: $pageName');
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendPageView(route);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendPageView(newRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendPageView(previousRoute);
    }
  }
}
