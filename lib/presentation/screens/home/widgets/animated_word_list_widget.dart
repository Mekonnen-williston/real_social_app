part of '../home_screen.dart';

/// A widget that displays a list of words with animated transitions.
///
/// This widget uses an [AnimatedList] to provide a smooth transition effect when adding new words.
/// It takes a list of [Word] objects and displays them in a card format.
///
class _AnimatedWordListWidget extends StatefulWidget {
  const _AnimatedWordListWidget({required this.words});
  final List<Word> words;

  @override
  _AnimatedWordListWidgetState createState() => _AnimatedWordListWidgetState();
}

class _AnimatedWordListWidgetState extends State<_AnimatedWordListWidget> {
  /// A key to manage the state of the animated list.
  /// This key is used to perform operations like inserting and removing items from the list.
  ///
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  /// A controller to manage the scroll position of the list.
  final ScrollController _scrollController = ScrollController();

  /// A list to hold the words displayed in the animated list.
  /// This list is initialized with the words provided by the widget.
  late List<Word> _words;

  @override
  void initState() {
    super.initState();
    // Initialize internal list with the initial words.
    _words = List.from(widget.words);
  }

  /// This method is called when the widget is updated.
  /// It updates the internal list of words with the new list provided by the widget.
  ///
  @override
  void didUpdateWidget(covariant _AnimatedWordListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateList(widget.words);
  }

  /// Updates the list of words by inserting new items that are not already in the list.
  ///
  void _updateList(List<Word> newList) {
    /// Insert new items that are not already in the list.
    for (int i = 0; i < newList.length; i++) {
      final newItem = newList[i];
      if (!_words.any((existingItem) => existingItem.id == newItem.id)) {
        setState(() {
          _words.insert(i, newItem);
          _listKey.currentState?.insertItem(
            i,
            duration: const Duration(milliseconds: 300),
          );
        });
        _scrollToBottom();
      }
    }
  }

  /// Scrolls to the bottom of the list when a new item is added.
  ///
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Builds the animated item for the list.
  ///
  Widget _buildItem(Word word, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: _WordCardWidget(word: word),
    );
  }

  /// Disposes the scroll controller when the widget is removed from the widget tree.
  ///
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      controller: _scrollController,
      initialItemCount: _words.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index, animation) {
        final word = _words[index];
        return _buildItem(word, animation);
      },
    );
  }
}
