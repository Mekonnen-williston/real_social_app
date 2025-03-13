import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.title, required this.actions});

  /// The title of the AppBar.
  ///
  final String title;

  /// The actions to be displayed in the AppBar.
  /// This can be a list of icons, buttons, or any other widgets.
  ///
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title), actions: actions);
  }

  /// The preferred size of the AppBar.
  /// This is used to determine the height of the AppBar.
  ///
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
