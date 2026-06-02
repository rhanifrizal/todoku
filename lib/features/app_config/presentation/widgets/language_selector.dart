import 'package:flutter/material.dart';
import 'package:todoku/core/localization/l10n_extension.dart';

class LanguageSelector extends StatelessWidget {
  final Locale currentLocale;
  final ValueChanged<Locale?> onLanguageChanged;

  const LanguageSelector({
    required this.currentLocale,
    required this.onLanguageChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(context.l10n.language),
      subtitle: Text(
        currentLocale.languageCode == 'ms'
            ? context.l10n.malay
            : context.l10n.english,
      ),
      trailing: DropdownButton<Locale>(
        value: currentLocale,
        items: [
          DropdownMenuItem(
            value: const Locale('en'),
            child: Text(context.l10n.english),
          ),
          DropdownMenuItem(
            value: const Locale('ms'),
            child: Text(context.l10n.malay),
          ),
        ],
        onChanged: onLanguageChanged,
      ),
    );
  }
}
