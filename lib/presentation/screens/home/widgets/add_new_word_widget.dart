part of '../home_screen.dart';

/// Widget to add a new word to the list.
///
/// This widget contains a text field for user input and a button to submit the new word.
/// It uses a [TextEditingController] to manage the input and a loading state
/// to show a loading indicator while the word is being added.
/// It also handles the submission of the new word and shows a toast notification
/// when the word count reaches certain milestones.
///
class _AddNewWordWidget extends ConsumerStatefulWidget {
  const _AddNewWordWidget();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __AddNewWordWidgetState();
}

class __AddNewWordWidgetState extends ConsumerState<_AddNewWordWidget> {
  /// TextEditingController to handle the input for the new word
  final _controller = TextEditingController();

  /// Loading state to show a loading indicator when adding a new word
  bool _isLoading = false;

  /// Method to handle the submission of a new word
  /// It checks if the input is not empty, shows a loading indicator,
  /// adds the word to the list, clears the input field, and unfocuses the text field
  ///
  Future<void> _submit() async {
    final text = _controller.text;
    if (text.trim().isNotEmpty) {
      // Show loading indicator
      setState(() => _isLoading = true);
      await ref.read(wordRepositoryProvider).addWord(text.trim());
      _controller.clear();
      // Hide loading indicator
      if (mounted) setState(() => _isLoading = false);
      // Unfocus the text field
      if (mounted) FocusScope.of(context).unfocus();

      // Show toast notification for milestone counts
      await _showMilestoneToast();
    }
  }

  /// Method to show a toast notification when the word count reaches certain milestones
  /// It checks the current word count and displays a toast message if it matches any of the milestone counts
  ///
  Future<void> _showMilestoneToast() async {
    /// Milestone counts for toast notifications.
    const List<int> milestoneCounts = [5, 12, 17, 21, 25];

    /// Delay to ensure the word count is updated before checking the milestones.

    await Future.delayed(const Duration(milliseconds: 300));
    final currentCount = await ref.read(wordRepositoryProvider).getWordCount();
    if (milestoneCounts.contains(currentCount)) {
      if (mounted) {
        ToastWidget.show(
          context,
          message: AppStrings.wordCountToast(currentCount),
          type: ToastType.success,
        );
      }
    }
  }

  /// Method to handle the disposal of the TextEditingController
  /// It ensures that the controller is disposed of properly
  ///
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Method to create the decoration for the text field
  ///
  InputDecoration _decoration() => const InputDecoration(
    labelText: AppStrings.typeNewWordLabel,
    border: OutlineInputBorder(),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _controller,
              decoration: _decoration(),
              onSubmitted: (_) => _submit(),
              onEditingComplete: () => _submit(),
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          const SizedBox(width: 8),
          _isLoading
              ? const LoadingWidget(scale: 0.75)
              : IconButton.filled(
                onPressed: () => _submit(),
                icon: const Icon(Icons.add),
              ),
        ],
      ),
    );
  }
}
