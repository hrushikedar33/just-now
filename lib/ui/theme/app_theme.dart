import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'color_constatns.dart';

class SysTheme extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppTheme {
  static final darkTheme = ThemeData(
    fontFamily: "OpenSans",
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    iconTheme: IconThemeData(color: kContentColorDarkTheme),
    textTheme: TextTheme(bodyText1: TextStyle(color: kContentColorDarkTheme)),
    colorScheme: ColorScheme.dark(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kContentColorLightTheme,
      selectedItemColor: Colors.white70,
      unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
    // cardColor: kContentColorLightTheme,
    cardTheme: CardTheme(
      color: Colors.blueGrey[600],
      shadowColor: Colors.white70,
    ),
  );

  static final lightTheme = ThemeData(
    fontFamily: "OpenSans",
    scaffoldBackgroundColor: Colors.white,
    primaryColor: kPrimaryColor,
    colorScheme: ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    iconTheme: IconThemeData(color: kContentColorLightTheme, opacity: 0.8),
    textTheme: TextTheme(bodyText1: TextStyle(color: kContentColorLightTheme)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: kContentColorLightTheme.withOpacity(0.7),
      unselectedItemColor: kContentColorLightTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
    // cardColor: kContentColorDarkTheme,
    cardTheme: CardTheme(
      color: Colors.green[100],
      shadowColor: Colors.grey,
    ),
  );

  static get kContentColorLigntTheme => null;
}
