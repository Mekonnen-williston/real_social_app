import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_social_app/core/assets.dart';
import 'package:real_social_app/core/extensions.dart';
import 'package:real_social_app/core/router/app_router.dart';
import 'package:real_social_app/core/theme/app_colors.dart';
import 'package:real_social_app/presentation/providers/auth_provider.dart';
import 'package:real_social_app/presentation/widgets/toast_widget.dart';

class GoogleSignInWidget extends ConsumerWidget {
  const GoogleSignInWidget({super.key});

  /// Handles the Google sign-in process.
  ///
  Future<void> _handleLogin(WidgetRef ref) async {
    final authRepo = ref.read(authRepositoryProvider);
    try {
      /// Attempt to sign in with Google.
      /// If successful, navigate to the HomeRoute.
      /// If an error occurs, show a toast message.
      ///
      await authRepo.signInWithGoogle();
      final context = appRouterKey.currentContext;
      if (context == null || !context.mounted) {
        return;
      }

      AutoRouter.of(context).replace(const HomeRoute());
    } catch (error) {
      final context = appRouterKey.currentContext;
      if (context == null || !context.mounted) {
        return;
      }

      ToastWidget.show(context, message: context.lango.loginErrorMessage);
    }
  }

  /// Returns the style for the button.
  ///
  ButtonStyle _style() => FilledButton.styleFrom(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.black,
    minimumSize: const Size(265, 44),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: AppColors.grey, width: 1),
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: FilledButton.icon(
        onPressed: () => _handleLogin(ref),
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            Assets.googleLogo,
            height: 48,
            width: 48,
            fit: BoxFit.cover,
          ),
        ),
        label: Text(context.lango.signInWithGoogle),
        style: _style(),
      ),
    );
  }
}
