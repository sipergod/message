import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:message/Component/FirebaseMessageConfig.dart';
import 'package:message/Static/ApplicationInitSettings.dart';
import 'package:message/Static/LocalAuthenticationService.dart';
import 'package:message/Static/LocalNotificationService.dart';
import 'package:message/Static/PageRouteName.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Init {
  Init._();
  static final instance = Init._();

  late ApplicationInitSettings initSetting;

  Future<void> initialize() async {
    initSetting = ApplicationInitSettings.instance;

    initSetting.sharedPreferences = await SharedPreferences.getInstance();

    if (kIsWeb) {
    } else {
      FirebaseMessageConfig.initialize();

      LocalNotificationService.notificationService.initialize();
      LocalAuthenticationService.localAuthenticationConfig.initialize();
    }

    setThemeIsSystem(initSetting);
    setThemeIsDark(initSetting);
    setAppPasscode(initSetting);
    setAppPasscodeLength(initSetting);
  }

  bool checkForLockingApp() {
    if (initSetting.appPasscode.isNotEmpty &&
        initSetting.appPasscodeLength != 0 &&
        initSetting.currentPageName != PageRouteName.lockScreenRoute) {
      print('check locking app: true');
      return true;
    }
    return false;
  }

  void addEventAppLifecycleState(
      AppLifecycleState appLifecycleState, State state) {
    switch (appLifecycleState) {
      case AppLifecycleState.paused:
        print('app state paused');
        if (checkForLockingApp()) {
          initSetting.state = state;
          Navigator.of(initSetting.state.context)
              .pushNamed(PageRouteName.lockScreenRoute);
        }

        break;
      case AppLifecycleState.resumed:
        print('app state resumed');
        break;
      case AppLifecycleState.inactive:
        print('app state inactive');
        break;
      case AppLifecycleState.detached:
        print('app state detached');
        break;
    }
  }

  void setThemeIsSystem(ApplicationInitSettings initSetting) {
    if (initSetting.sharedPreferences.getBool('themeIsSystem') == null) {
      initSetting.sharedPreferences.setBool('themeIsSystem', false);
    } else {
      initSetting.themeIsSystem = ApplicationInitSettings
          .instance.sharedPreferences
          .getBool('themeIsSystem')!;
    }
  }

  void setThemeIsDark(ApplicationInitSettings initSetting) {
    if (initSetting.sharedPreferences.getBool('themeIsDark') == null) {
      initSetting.sharedPreferences.setBool('themeIsDark', false);
    } else {
      initSetting.themeIsDark = ApplicationInitSettings
          .instance.sharedPreferences
          .getBool('themeIsDark')!;
    }
  }

  void setAppPasscode(ApplicationInitSettings initSetting) {
    if (initSetting.sharedPreferences.getString('appPasscode') == null) {
      initSetting.sharedPreferences.setString('appPasscode', '');
    } else {
      initSetting.appPasscode = ApplicationInitSettings
          .instance.sharedPreferences
          .getString('appPasscode')!;
    }
  }

  void setAppPasscodeLength(ApplicationInitSettings initSetting) {
    if (initSetting.sharedPreferences.getInt('appPasscodeLength') == null) {
      initSetting.sharedPreferences.setInt('appPasscodeLength', 0);
    } else {
      initSetting.appPasscodeLength = ApplicationInitSettings
          .instance.sharedPreferences
          .getInt('appPasscodeLength')!;
    }
  }
}
