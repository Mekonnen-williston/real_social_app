import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_social_app/core/extensions.dart';
import 'package:real_social_app/core/theme/app_colors.dart';

/// A widget that displays an error message and a retry button.
///
class RetryWidget extends ConsumerWidget {
  const RetryWidget({super.key, this.message, this.onRetry});

  /// The message to display. If null, a default error message is shown.
  ///
  final String? message;

  /// The callback function to be executed when the retry button is pressed.
  ///
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 50, color: AppColors.red),
            const SizedBox(height: 16),
            Text(
              message ?? context.lango.errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(context.lango.retry),
            ),
          ],
        ),
      ),
    );
  }
}
