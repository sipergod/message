import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:message/Static/AppThemes.dart';
import 'package:message/Static/ApplicationInitSettings.dart';

class SettingPageEvent {
  State state;
  SettingPageEvent(this.state);

  bool themeStyleIsSystem = ApplicationInitSettings.instance.themeIsSystem;
  bool themeStyleIsDark = ApplicationInitSettings.instance.themeIsDark;
  ApplicationInitSettings initSettings = ApplicationInitSettings.instance;

  Future<void> preLoad() async {}

  void changeThemeMode(bool checked) async {
    state.setState(() {
      themeStyleIsSystem = checked;
      ApplicationInitSettings.instance.themeIsSystem = checked;
      initSettings.sharedPreferences.setBool('themeIsSystem', checked);
    });

    await DynamicTheme.of(state.context)!.setTheme(setThemeSystem(checked));
  }

  void changeThemeStyle(bool checked) async {
    state.setState(() {
      themeStyleIsDark = checked;
      ApplicationInitSettings.instance.themeIsDark = checked;
      initSettings.sharedPreferences.setBool('themeIsDark', checked);
    });

    await DynamicTheme.of(state.context)!.setTheme(
      checked ? AppThemes.Dark : AppThemes.Light,
    );
  }

  int setThemeSystem(bool checked) {
    if (checked) {
      return MediaQuery.of(state.context).platformBrightness == Brightness.dark
          ? AppThemes.Dark
          : AppThemes.Light;
    } else {
      return themeStyleIsDark ? AppThemes.Dark : AppThemes.Light;
    }
  }
}
