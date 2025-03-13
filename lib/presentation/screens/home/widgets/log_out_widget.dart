part of '../home_screen.dart';

class _LogOutWidget extends ConsumerWidget {
  const _LogOutWidget();

  /// This method handles the logout process.
  /// It signs out the user using the auth repository and navigates to the LoginRoute.
  ///
  Future<void> _logout(WidgetRef ref) async {
    final authRepo = ref.read(authRepositoryProvider);
    await authRepo.signOut();

    final context = appRouterKey.currentContext;
    if (context == null || !context.mounted) {
      return;
    }

    // Clear the navigation stack and navigate to the LoginRoute
    // to prevent going back to the previous screen.
    AutoRouter.of(context).replace(const LoginRoute());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: () async => await _logout(ref),
        icon: const Icon(Icons.logout),
        tooltip: AppStrings.logoutTooltip,
      ),
    );
  }
}
