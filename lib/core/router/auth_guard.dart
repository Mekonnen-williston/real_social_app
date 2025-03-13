import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_social_app/core/router/app_router.dart';
import 'package:real_social_app/presentation/providers/auth_provider.dart';

class AuthGuard extends AutoRouteGuard {

  /// This guard checks if the user is authenticated before allowing navigation.
  /// If the user is not authenticated, it redirects to the LoginRoute.
  /// 
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final context = router.navigatorKey.currentContext;
    if (context == null) {
      resolver.next(false);
      return;
    }

    // Using Riverpod's ProviderScope to read the auth state.
    final container = ProviderScope.containerOf(context);
    final user = container.read(authStateProvider);

    if (user != null) {
      // User is authenticated, allow navigation.
      resolver.next(true);
    } else {
      // User is not authenticated; push the LoginRoute.
      router
          .push(LoginRoute())
          .then((result) {
            // For simplicity, we assume the login was successful and resume navigation.
            resolver.next(true);
          })
          .onError((error, stackTrace) {
            // In case login failed
            resolver.next(false);
          });
    }
  }
}
