import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_social_app/core/app_strings.dart';
import 'package:real_social_app/core/l10n/generated/app_localizations.dart';
import 'package:real_social_app/core/l10n/l10n.dart';
import 'package:real_social_app/core/l10n/language_controller.dart';
import 'package:real_social_app/core/router/app_router.dart';

import 'core/theme/app_theme_controller.dart';
import 'data/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the Supabase service to set up the connection to the Supabase backend.
  ///
  await SupabaseService.initialize();

  /// Initialize the ThemeControllerProvider to set up the theme mode based on user preferences.
  /// This will load the saved theme mode from shared preferences and apply it to the app.
  /// The theme mode can be light, dark, or system default.
  ///
  await ThemeControllerProvider().initialize();

  /// The [ProviderScope] widget is the root of the application and provides the necessary
  /// context for Riverpod providers.
  ///
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  /// The [AppRouter] instance is created here to handle the routing of the application.
  /// This instance is used to delegate the routing and parse the route information.
  ///
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageControllerProvider);

    final themeController = ref.watch(themeControllerProvider);
    return MaterialApp.router(
      title: AppStrings.appTitle,
      theme: themeController.lightThemeData,
      darkTheme: themeController.darkThemeData,
      themeMode: themeController.themeMode,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all,
      locale: Locale(language.code),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
