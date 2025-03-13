// import 'package:evnsteven/core/app_preferences.dart';
// import 'package:evnsteven/core/enums.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// part 'language_controller_provider.g.dart';

// @Riverpod(keepAlive: true)
// class LanguageController extends _$LanguageController {
//   @override
//   Lango build() {
//     _initialize();
//     return Lango.en;
//   }

//   Future<void> _initialize() async {
//     final prefs = await SharedPreferences.getInstance();
//     state = AppPreferences().getLanguage(prefs);
//   }

//   Future<void> updateLanguage(Lango language) async {
//     state = language;
//     await AppPreferences().setLanguage(language.code);
//   }
// }

// use State Notifier to manage the language state
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_social_app/core/app_preferences.dart';
import 'package:real_social_app/core/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends StateNotifier<Lango> {
  LanguageController() : super(Lango.en) {
    _initialize();
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    state = AppPreferences().getLanguage(prefs);
  }

  Future<void> updateLanguage(Lango language) async {
    state = language;
    await AppPreferences().setLanguage(language.code);
  }
}

final languageControllerProvider =
    StateNotifierProvider<LanguageController, Lango>((ref) {
      return LanguageController();
    });
