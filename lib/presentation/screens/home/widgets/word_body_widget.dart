part of '../home_screen.dart';

class _WordBodyWidget extends StatelessWidget {
  const _WordBodyWidget(this.words);

  /// The list of favorite words to be displayed.
  ///
  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Expanded(
          child:
              words.isEmpty
                  ? const _EmptyWordWidget()
                  : _AnimatedWordListWidget(words: words),
        ),
        _AddNewWordWidget(),
      ],
    );
  }
}
