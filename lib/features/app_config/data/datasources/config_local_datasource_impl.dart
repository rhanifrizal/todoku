import 'package:todoku/core/utils/secure_storage_helper.dart';
import 'package:todoku/features/app_config/data/datasources/config_local_datasource.dart';

final class ConfigLocalDataSourceImpl implements ConfigLocalDataSource {
  final SecureStorageHelper _storageHelper;

  static const _themeKey = 'pref_theme_mode';
  static const _localeKey = 'pref_locale_lang';

  const ConfigLocalDataSourceImpl({required SecureStorageHelper storageHelper})
    : _storageHelper = storageHelper;

  @override
  Future<String?> getThemeMode() async {
    return await _storageHelper.read(_themeKey);
  }

  @override
  Future<void> cacheThemeMode(String theme) async {
    await _storageHelper.write(_themeKey, theme);
  }

  @override
  Future<String?> getLanguageCode() async {
    return await _storageHelper.read(_localeKey);
  }

  @override
  Future<void> cacheLanguageCode(String langCode) async {
    await _storageHelper.write(_localeKey, langCode);
  }
}
