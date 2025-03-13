import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_social_app/core/app_preferences.dart';
import 'package:real_social_app/core/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeControllerProvider extends ChangeNotifier {
  final AppPreferences _appPref = AppPreferences();
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeData get lightThemeData => FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
  ).copyWith(cardTheme: const CardTheme(color: AppColors.cardColorLight));

  ThemeData get darkThemeData => FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
  ).copyWith(cardTheme: const CardTheme(color: AppColors.cardColorDark));

  Future<ThemeData> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = _appPref.getThemeMode(prefs);
    notifyListeners();
    switch (_themeMode) {
      case ThemeMode.light:
        return lightThemeData;
      case ThemeMode.dark:
        return darkThemeData;
      case ThemeMode.system:
        return darkThemeData;
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    await _appPref.setThemeMode(themeMode);
    notifyListeners();
  }
}

final themeControllerProvider = ChangeNotifierProvider<ThemeControllerProvider>(
  (ref) => ThemeControllerProvider(),
);
