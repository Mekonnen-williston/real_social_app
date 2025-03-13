import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:real_social_app/core/router/app_router.dart';
import 'package:real_social_app/presentation/widgets/loading_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirectBasedOnAuth();
  }

  /// Redirects the user to the appropriate screen based on their authentication status.
  /// If the user is authenticated, they are redirected to the HomeRoute.
  /// If not, they are redirected to the LoginRoute.
  ///
  Future<void> _redirectBasedOnAuth() async {
    // Optional delay to show the splash screen
    await Future.delayed(const Duration(seconds: 2));
    final session = Supabase.instance.client.auth.currentSession;
    final context = appRouterKey.currentContext;

    // Check if the context is mounted before navigating
    if (context == null || !context.mounted) {
      return;
    }
    if (session != null) {
      // If a session exists, redirect to the AppScreen.

      AutoRouter.of(context).replace(const HomeRoute());
    } else {
      // Otherwise, redirect to the LoginScreen.
      AutoRouter.of(context).replace(const LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(fullScreen: true);
  }
}
