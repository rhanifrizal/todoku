// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'TodoKu';

  @override
  String get noTaskFoundCreateOne => 'Tiada tugasan ditemui. Cipta satu!';

  @override
  String get newTask => 'Tugasan Baharu';

  @override
  String get title => 'Tajuk';

  @override
  String get description => 'Keterangan';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String routePathNotFound(Object path) {
    return 'Laluan navigasi tidak ditemui: $path';
  }

  @override
  String get settings => 'Tetapan';

  @override
  String get darkMode => 'Mod Gelap';

  @override
  String currentTheme(String theme) {
    return 'Semasa: $theme';
  }

  @override
  String get language => 'Bahasa';

  @override
  String get english => 'English';

  @override
  String get malay => 'Bahasa Melayu';
}
