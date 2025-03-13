import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_social_app/core/enums.dart';
import 'package:real_social_app/core/extensions.dart';
import 'package:real_social_app/core/l10n/language_controller.dart';

class LanguageSwitchIconButton extends ConsumerStatefulWidget {
  const LanguageSwitchIconButton({super.key});

  @override
  ConsumerState<LanguageSwitchIconButton> createState() =>
      _LanguageSwitchIconButtonState();
}

class _LanguageSwitchIconButtonState
    extends ConsumerState<LanguageSwitchIconButton> {
  bool _isSwitching = false;

  @override
  Widget build(BuildContext context) {
    final currentLanguage = ref.watch(languageControllerProvider);
    final List<Lango> languages = List.from(Lango.values);

    return IconButton(
      icon: const Icon(Icons.language),
      tooltip: context.lango.changeLanguage,
      onPressed: () async {
        if (_isSwitching) return;
        setState(() => _isSwitching = true);

        final selectedLanguage = await showDialog<Lango>(
          context: context,
          builder:
              (context) => _LanguageDialog(
                languages: languages,
                currentLanguage: currentLanguage,
              ),
        );
        if (selectedLanguage != null && selectedLanguage != currentLanguage) {
          await ref
              .read(languageControllerProvider.notifier)
              .updateLanguage(selectedLanguage);
        }
        if (mounted) {
          setState(() => _isSwitching = false);
        }
      },
    );
  }
}

class _LanguageDialog extends StatelessWidget {
  const _LanguageDialog({
    required this.languages,
    required this.currentLanguage,
  });

  final List<Lango> languages;
  final Lango currentLanguage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.lango.changeLanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            languages.map((lang) {
              return RadioListTile<Lango>(
                value: lang,
                groupValue: currentLanguage,
                title: Text(lang.name),
                onChanged: (value) => Navigator.of(context).pop(value),
              );
            }).toList(),
      ),
    );
  }
}
