/// This file contains all the string constants used in the app.
/// It includes titles, error messages, and other text used throughout the app.
///
class AppStrings {
  /// This class contains all the string constants used in the app.
  static const String appTitle = 'RealSocial';

  /// Login Screen
  static const String signInWithGoogle = 'Sign in with Google';
  static const String loginErrorMessage =
      'Failed to sign in. Please try again.';

  /// App Screen
  static const String favoriteWordsTitle = 'Favorite Words';
  static const String typeNewWordLabel = 'Type new word...';
  static const String logoutTooltip = 'Logout';
  static const String noWordsMessage = 'No words found. Please add some words.';
  static const String errorMessage = 'Something went wrong. Please try again.';
  static const String retry = 'Retry';

  /// Toast messages
  static String wordCountToast(int count) => 'You have $count words!';
}
