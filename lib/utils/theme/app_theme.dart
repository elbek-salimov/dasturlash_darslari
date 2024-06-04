import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class AppTheme {
  static final ThemeData lightTheme = LightTheme.lightTheme;
  static final ThemeData darkTheme = DarkTheme.darkTheme;
}

extension IsDarkMode on BuildContext {
  bool isDarkTheme() {
    AdaptiveThemeMode currentMode = AdaptiveTheme.of(this).mode;
    if (currentMode == AdaptiveThemeMode.system) {
      Brightness currentBrightness = MediaQuery.of(this).platformBrightness;
      return currentBrightness == Brightness.dark;
    }

    return currentMode == AdaptiveThemeMode.dark;
  }
}
