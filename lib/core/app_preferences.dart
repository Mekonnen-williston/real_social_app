import 'package:flutter/material.dart';
import 'package:real_social_app/core/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _themeKey = 'theme_mode';

  ThemeMode getThemeMode(SharedPreferences prefs) {
    final themeString = prefs.getString(_themeKey);
    if (themeString == 'light') return ThemeMode.light;
    if (themeString == 'dark') return ThemeMode.dark;
    return ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    String themeString;
    switch (themeMode) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      default:
        themeString = 'system';
    }
    await prefs.setString(_themeKey, themeString);
  }

  Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  Lango getLanguage(SharedPreferences prefs) {
    final languageString = prefs.getString('language');
    if (languageString == null) {
      return Lango.en;
    } else {
      return Lango.values.firstWhere(
        (lango) => lango.code == languageString,
        orElse: () => Lango.en,
      );
    }
  }
}
