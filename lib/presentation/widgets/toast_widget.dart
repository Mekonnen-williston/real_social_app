import 'package:flutter/material.dart';

/// an Enum to represent different types of Toast messages
/// and their respective colors.
/// - success: Green color
/// - error: Red color
/// - info: Blue color
/// - warning: Orange color
enum ToastType { success, error, info, warning }

/// an Enum to represent different positions of Toast messages
/// - top: Toast appears at the top of the screen
/// - center: Toast appears at the center of the screen
/// - bottom: Toast appears at the bottom of the screen
/// The default position is bottom.
enum ToastPosition { top, center, bottom }

/// A widget that displays a Toast message.
/// It can be used to show success, error, info, or warning messages.
/// It can be positioned at the top, center, or bottom of the screen.
/// It can also be dismissed by swiping it away.
/// It has a customizable duration, background color, text color, and icon.
/// The Toast message can be dismissed by tapping on it or swiping it away.
/// The Toast message will automatically disappear after the specified duration.
/// It can also execute a callback function when it is dismissed.
///
class ToastWidget extends StatelessWidget {
  /// The message to be displayed in the Toast.
  final String message;

  /// The type of the Toast message.
  final ToastType type;

  /// The position of the Toast message.
  final ToastPosition position;

  /// The duration for which the Toast message will be displayed.
  final Duration duration;

  /// The callback function to be executed
  final VoidCallback? onDismiss;

  /// The background color of the Toast message.
  final Color? backgroundColor;

  /// The text color of the Toast message.
  final Color? textColor;

  /// The icon to be displayed in the Toast message.
  /// If not provided, a default icon will be used based on the Toast type.
  /// The default icon for success is a check mark,
  ///
  final Widget? icon;

  const ToastWidget({
    super.key,
    required this.message,
    this.type = ToastType.info,
    this.position = ToastPosition.bottom,
    this.duration = const Duration(seconds: 2),
    this.onDismiss,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    ToastPosition position = ToastPosition.bottom,
    Duration? duration,
    Color? backgroundColor,
    Color? textColor,
    Widget? icon,
    VoidCallback? onDismiss,
  }) {
    if (message.isEmpty) return;

    if (!context.mounted) return;
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: position == ToastPosition.top ? 50 : null,
            bottom: position == ToastPosition.bottom ? 50 : null,
            left: 0,
            right: 0,
            child: SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: _getAlignment(position),
                child: ToastWidget(
                  message: message,
                  type: type,
                  position: position,
                  duration: duration ?? const Duration(seconds: 3),
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                  icon: icon,
                  onDismiss: onDismiss,
                ),
              ),
            ),
          ),
    );

    overlay.insert(entry);
    Future.delayed(duration ?? const Duration(seconds: 3)).then((_) {
      entry.remove();
      onDismiss?.call();
    });
  } 

  static Alignment _getAlignment(ToastPosition position) {
    switch (position) {
      case ToastPosition.top:
        return Alignment.topCenter;
      case ToastPosition.center:
        return Alignment.center;
      case ToastPosition.bottom:
        return Alignment.bottomCenter;
    }
  }

  Color _getBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;
    switch (type) {
      case ToastType.success:
        return Colors.green.shade700;
      case ToastType.error:
        return Colors.red.shade700;
      case ToastType.warning:
        return Colors.orange.shade700;
      case ToastType.info:
        return Colors.blue.shade700;
    }
  }

  Color _getTextColor() {
    if (textColor != null) return textColor!;
    return Colors.white;
  }

  Widget _getIcon() {
    if (icon != null) return icon!;
    switch (type) {
      case ToastType.success:
        return const Icon(Icons.check_circle, color: Colors.white);
      case ToastType.error:
        return const Icon(Icons.error, color: Colors.white);
      case ToastType.warning:
        return const Icon(Icons.warning, color: Colors.white);
      case ToastType.info:
        return const Icon(Icons.info, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (_) => onDismiss?.call(),
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getIcon(),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _getTextColor(),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
