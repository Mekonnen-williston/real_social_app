import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_social_app/core/theme/app_theme_controller.dart';

class ThemeSwitcherWidget extends ConsumerWidget {
  const ThemeSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;

    return IconButton(
      onPressed: () async {
        await ref
            .read(themeControllerProvider.notifier)
            .setThemeMode(
              brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark,
            );
      },
      icon: Icon(
        brightness == Brightness.dark ? Icons.dark_mode : Icons.light_mode,
        color: Theme.of(context).buttonTheme.colorScheme?.primary,
      ),
    );
  }
}
