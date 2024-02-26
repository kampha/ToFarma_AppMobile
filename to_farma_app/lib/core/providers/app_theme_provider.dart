import 'package:flutter/material.dart';
import 'package:to_farma_app/app/themes/themes,.dart';

class AppThemeProvider with ChangeNotifier {
  AppThemeProvider()
      : themeData = lightTheme,
        isDarkTheme = false;

  late ThemeData themeData;
  late bool isDarkTheme;

  ThemeMode get themeMode => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void setDarkTheme() {
    themeData = darkTheme;
    isDarkTheme = true;
    notifyListeners();
  }

  void setLightTheme() {
    themeData = lightTheme;
    isDarkTheme = false;
    notifyListeners();
  }
}
