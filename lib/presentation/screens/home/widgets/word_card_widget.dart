part of '../home_screen.dart';

class _WordCardWidget extends ConsumerWidget {
  const _WordCardWidget({required this.word});

  /// The word to be displayed in the card.
  ///
  final Word word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(title: Text(word.titleCase)),
    );
  }
}
