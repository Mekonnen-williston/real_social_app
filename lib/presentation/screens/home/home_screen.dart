import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_social_app/core/app_strings.dart';
import 'package:real_social_app/core/router/app_router.dart';
import 'package:real_social_app/models/extensions/word_extension.dart';
import 'package:real_social_app/models/word.dart';
import 'package:real_social_app/presentation/providers/auth_provider.dart';
import 'package:real_social_app/presentation/providers/word_provider.dart';
import 'package:real_social_app/presentation/widgets/loading_widget.dart';
import 'package:real_social_app/presentation/widgets/retry_widget.dart';
import 'package:real_social_app/presentation/widgets/toast_widget.dart';

part 'widgets/add_new_word_widget.dart';
part 'widgets/animated_word_list_widget.dart';
part 'widgets/empty_word_widget.dart';
part 'widgets/log_out_widget.dart';
part 'widgets/word_body_widget.dart';
part 'widgets/word_card_widget.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  /// This method is called when the user pulls down to refresh the list of favorite words.
  /// It invalidates the [favoriteWordsStreamProvider] to fetch the latest data.
  ///
  Future<void> _onRefresh(WidgetRef ref) async {
    ref.invalidate(favoriteWordsStreamProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteWordsAsync = ref.watch(favoriteWordsStreamProvider);

    return RefreshIndicator.adaptive(
      onRefresh: () => _onRefresh(ref),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.favoriteWordsTitle),
          actions: const [_LogOutWidget()],
        ),
        body: SafeArea(
          child: favoriteWordsAsync.when(
            data: (words) => _WordBodyWidget(words),
            loading: () => const LoadingWidget(),
            error: (_, _) {
              return RetryWidget(
                onRetry: () => _onRefresh(ref),
                message: AppStrings.errorMessage,
              );
            },
          ),
        ),
      ),
    );
  }
}
