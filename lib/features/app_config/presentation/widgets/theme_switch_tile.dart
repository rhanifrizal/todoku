import 'package:flutter/material.dart';
import 'package:todoku/core/localization/l10n_extensions.dart';

class ThemeSwitchTile extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<bool> onThemeChanged;

  const ThemeSwitchTile({
    required this.themeMode,
    required this.onThemeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final displayThemeName = themeMode.name.toUpperCase();

    return ListTile(
      title: Text(context.l10n.darkMode),
      subtitle: Text(context.l10n.currentTheme(displayThemeName)),
      trailing: Switch(
        value: themeMode == ThemeMode.dark,
        onChanged: onThemeChanged,
      ),
    );
  }
}
