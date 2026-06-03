import 'package:flutter/material.dart';
import 'package:todoku/core/localization/l10n/app_localizations.dart';

extension AppContextExtension on BuildContext {
  /// Quick access to localized strings
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// Access the main ThemeData object
  ThemeData get theme => Theme.of(this);

  /// Access the application's ColorScheme directly
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Access TextTheme typography rules
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get the screen size constraints
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Get device orientation status
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// Quick shortcut to check if keyboard is open/visible
  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;

  /// Get the bottom view insets (typically used to check keyboard height)
  double get bottomInsets => MediaQuery.viewInsetsOf(this).bottom;
}
