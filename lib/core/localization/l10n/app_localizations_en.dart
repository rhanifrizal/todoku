// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TodoKu';

  @override
  String get noTaskFoundCreateOne => 'No tasks found. Create one!';

  @override
  String get newTask => 'New Task';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String routePathNotFound(Object path) {
    return 'Route path not found: $path';
  }

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String currentTheme(String theme) {
    return 'Current: $theme';
  }

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get malay => 'Bahasa Melayu';
}
