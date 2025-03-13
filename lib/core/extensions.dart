import 'package:flutter/material.dart';
import 'package:real_social_app/core/l10n/generated/app_localizations.dart';

extension ContextX on BuildContext {
  AppLocalizations get lango => AppLocalizations.of(this)!;
}
