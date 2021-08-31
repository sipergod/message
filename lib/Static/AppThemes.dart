import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static const int Light = 0;
  static const int Dark = 1;
  static const int LightBlue = 2;
  static const int LightRed = 3;
  static const int DarkBlue = 4;
  static const int DarkRed = 5;

}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.Light: ThemeData.light(),
    AppThemes.Dark: ThemeData.dark(),
    AppThemes.LightBlue: ThemeData(
      primarySwatch: Colors.blue,
    ),
    AppThemes.LightRed: ThemeData(
      primarySwatch: Colors.red,
    ),
    AppThemes.DarkBlue: ThemeData.dark().copyWith(
      accentColor: Colors.blue,
      buttonTheme:
          ThemeData.dark().buttonTheme.copyWith(buttonColor: Colors.grey[700]),
      floatingActionButtonTheme: ThemeData.dark()
          .floatingActionButtonTheme
          .copyWith(backgroundColor: Colors.blue),
    ),
    AppThemes.DarkRed: ThemeData.from(
      colorScheme: ColorScheme.dark(primary: Colors.red, secondary: Colors.red),
    ),
  },
  fallbackTheme: ThemeData.light(),
);
