import 'package:flutter/material.dart';

class AppColors {
  // Basic colors.
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color red = Colors.red;

  // Toast message colors.
  // (Note: shade values cannot be const so we use final.)
  static final Color toastSuccess = Colors.green.shade700;
  static final Color toastError = Colors.red.shade700;
  static final Color toastWarning = Colors.orange.shade700;
  static final Color toastInfo = Colors.blue.shade700;

  // Box shadow color.
  static final Color boxShadowColor = Colors.black.withValues(alpha: 0.1);
}
