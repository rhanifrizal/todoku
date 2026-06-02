import 'package:flutter/material.dart';
import 'package:todoku/core/localization/l10n_extension.dart';
import 'package:todoku/features/app_config/presentation/widgets/language_selector.dart';
import 'package:todoku/features/app_config/presentation/widgets/theme_switch_tile.dart';

class SettingsView extends StatelessWidget {
  final ThemeMode themeMode;
  final Locale locale;
  final VoidCallback onThemeToggle;
  final ValueChanged<Locale> onLanguageChanged;

  const SettingsView({
    required this.themeMode,
    required this.locale,
    required this.onThemeToggle,
    required this.onLanguageChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ThemeSwitchTile(
            themeMode: themeMode,
            onThemeChanged: (_) => onThemeToggle(),
          ),
          const Divider(),
          LanguageSelector(
            currentLocale: locale,
            onLanguageChanged: (newLocale) {
              if (newLocale != null) onLanguageChanged(newLocale);
            },
          ),
        ],
      ),
    );
  }
}
