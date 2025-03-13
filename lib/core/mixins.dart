import 'package:flutter/foundation.dart';

/// Mixin to provide logging functionality.
/// 
mixin LoggerMixin {
  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    debugPrint('ERROR: $message\n$error\n$stackTrace');
  }

  void logInfo(String message) {
    debugPrint('INFO: $message');
  }
}

/// Mixin to encapsulate common Supabase call behavior (error handling & logging).
mixin SupabaseHelperMixin on LoggerMixin {
  Future<T> handleSupabaseCall<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      logInfo("Supabase call succeeded: $result");
      return result;
    } catch (error, stackTrace) {
      logError("Supabase call failed", error, stackTrace);
      rethrow;
    }
  }
}
