import 'package:flutter/material.dart';
import 'package:todoku/core/extensions/context_extensions.dart';

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
    final String localizedModeName = switch (themeMode) {
      ThemeMode.system => context.l10n.themeSystem,
      ThemeMode.light => context.l10n.themeLight,
      ThemeMode.dark => context.l10n.themeDark,
    };

    return ListTile(
      title: Text(context.l10n.theme),
      subtitle: Text(context.l10n.currentTheme(localizedModeName)),
      trailing: Switch(
        value: themeMode == ThemeMode.dark,
        onChanged: onThemeChanged,
      ),
    );
  }
}
