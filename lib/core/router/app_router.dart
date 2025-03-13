import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:real_social_app/core/router/auth_guard.dart';
import 'package:real_social_app/presentation/screens/home/home_screen.dart';
import 'package:real_social_app/presentation/screens/log_in/login_screen.dart';
import 'package:real_social_app/presentation/screens/splash_screen.dart';

part 'app_router.gr.dart';

final GlobalKey<NavigatorState> appRouterKey = GlobalKey<NavigatorState>();

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter() : super(navigatorKey: appRouterKey);

  /// The list of route entries to match against
  @override
  List<AutoRoute> get routes => [
    /// The splash screen is now the initial route.
    AdaptiveRoute(page: SplashRoute.page, initial: true),

    /// The LoginRoute is the login screen.
    /// This is where the user will be redirected if they are not authenticated.
    ///
    AdaptiveRoute(page: LoginRoute.page),

    /// The HomeRoute is protected by the AuthGuard.
    /// This means that the user must be authenticated to access it.
    /// If not, they will be redirected to the LoginRoute.
    ///
    AdaptiveRoute(page: HomeRoute.page, guards: [AuthGuard()]),
  ];
}
