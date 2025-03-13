// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get language => 'שפה';

  @override
  String get signInWithGoogle => 'התחבר עם גוגל';

  @override
  String get loginErrorMessage => 'ההתחברות נכשלה. אנא נסה שוב.';

  @override
  String get favoriteWordsTitle => 'מילים מועדפות';

  @override
  String get typeNewWordLabel => 'הקלד מילה חדשה...';

  @override
  String get logoutTooltip => 'התנתק';

  @override
  String get noWordsMessage => 'לא נמצאו מילים. אנא הוסף מילים.';

  @override
  String get errorMessage => 'משהו השתבש. אנא נסה שוב.';

  @override
  String get retry => 'נסה שוב';

  @override
  String get changeLanguage => 'שנה שפה';

  @override
  String wordCountToast({required int count}) {
    return 'יש לך $count מילים!';
  }
}
