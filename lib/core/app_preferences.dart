import 'package:flutter/material.dart';
import 'package:real_social_app/core/app_constants.dart';
import 'package:real_social_app/core/enums.dart';
import 'package:real_social_app/core/theme/theme_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class that handles application preferences such as theme mode and language settings.
///
class AppPreferences {
  /// Sets the theme mode in shared preferences.
  ///
  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    String themeString;
    switch (themeMode) {
      case ThemeMode.light:
        themeString = ThemeStrings.light;
        break;
      case ThemeMode.dark:
        themeString = ThemeStrings.dark;
        break;
      default:
        themeString = ThemeStrings.system;
    }
    await prefs.setString(AppConstants.themeKey, themeString);
  }

  /// Gets the theme mode from shared preferences.
  ///
  ThemeMode getThemeMode(SharedPreferences prefs) {
    final themeString = prefs.getString(AppConstants.themeKey);
    if (themeString == ThemeStrings.light) return ThemeMode.light;
    if (themeString == ThemeStrings.dark) return ThemeMode.dark;
    return ThemeMode.system;
  }

  /// Sets the language in shared preferences.
  ///
  Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.languageKey, language);
  }

  /// Gets the language from shared preferences.
  ///
  Lango getLanguage(SharedPreferences prefs) {
    final languageString = prefs.getString(AppConstants.languageKey);
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
