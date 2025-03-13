part of '../home_screen.dart';

/// The widget that displays a message when there are no words available.
///
class _EmptyWordWidget extends StatelessWidget {
  const _EmptyWordWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          context.lango.noWordsMessage,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
