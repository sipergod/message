import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static const int Light = 0;
  static const int Dark = 1;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.Light: ThemeData.light(),
    AppThemes.Dark: ThemeData.dark(),
  },
  fallbackTheme: ThemeData.light(),
);
