import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message/Static/AppThemes.dart';
import 'package:message/Static/ApplicationInitSettings.dart';
import 'package:message/Static/PageRouteName.dart';
import 'package:message/UI/ElemBuilder.dart';

class SettingPageEvent {
  State state;
  Function setStateFunc;
  SettingPageEvent(this.state, this.setStateFunc);

  bool themeStyleIsSystem = ApplicationInitSettings.instance.themeIsSystem;
  bool themeStyleIsDark = ApplicationInitSettings.instance.themeIsDark;
  bool appPasscodeEnable =
      ApplicationInitSettings.instance.appPasscode.isNotEmpty &&
          ApplicationInitSettings.instance.appPasscodeLength != 0;

  ApplicationInitSettings initSettings = ApplicationInitSettings.instance;

  Future<void> preLoad() async {}

  void changeThemeMode(bool checked) async {
    setStateFunc(() {
      themeStyleIsSystem = checked;
      ApplicationInitSettings.instance.themeIsSystem = checked;
      initSettings.sharedPreferences.setBool('themeIsSystem', checked);
    });

    await DynamicTheme.of(state.context)!.setTheme(setThemeSystem(checked));
  }

  void changeThemeStyle(bool checked) async {
    setStateFunc(() {
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

  void activateAppPasscode(bool checked) {
    if (checked) {
      changeAppPasscode();
    } else {
      setStateFunc(() {
        appPasscodeEnable = checked;
      });
      savePasscode('', 0);
    }
  }

  void changeAppPasscode() async {
    bool result = await doSetPasscode();
    setStateFunc(() {
      if(ApplicationInitSettings.instance.appPasscode.isNotEmpty &&  ApplicationInitSettings.instance.appPasscodeLength != 0) {
        appPasscodeEnable = true;
      } else {
        appPasscodeEnable = false;
      }
    });
    if (result) {
    } else {
      ElemBuilder(state).buildAndShowSnackBar(
        'Setting new passcode fail!',
        '',
        () {},
      );
    }
  }

  Future<bool> doSetPasscode() async {
    String input = '';

    await Navigator.of(state.context).pushNamed(PageRouteName.createLockRoute).then((value) {
      print(value);
      if(value != null) {
        input = value.toString();
      }
    });

    if (input.isNotEmpty) {
      String encodePasscode = sha256.convert(utf8.encode(input)).toString();
      savePasscode(encodePasscode, input.length);
      return true;
    } else {
      return false;
    }
  }

  void savePasscode(String passcode, int length) {
    ApplicationInitSettings.instance.appPasscode = passcode;
    ApplicationInitSettings.instance.appPasscodeLength = length;
    initSettings.sharedPreferences.setString('appPasscode', passcode);
    initSettings.sharedPreferences.setInt('appPasscodeLength', length);
  }
}
