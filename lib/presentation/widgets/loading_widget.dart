import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.fullScreen = false, this.scale});

  /// If true, the loading indicator will cover the entire screen.
  /// If false, it will be a centered loading indicator.
  final bool? fullScreen;

  /// The scale of the loading indicator.
  /// If null, the default scale of 1.0 will be used.
  /// This can be used to make the loading indicator larger or smaller.
  ///
  final double? scale;

  Widget _loadingIndicator() => Center(
    child: Transform.scale(
      scale: scale ?? 1.0,
      child: CircularProgressIndicator.adaptive(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return fullScreen == true
        ? Scaffold(body: _loadingIndicator())
        : _loadingIndicator();
  }
}
