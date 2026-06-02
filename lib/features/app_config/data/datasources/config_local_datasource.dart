abstract interface class ConfigLocalDataSource {
  Future<String?> getThemeMode();

  Future<void> cacheThemeMode(String theme);

  Future<String?> getLanguageCode();

  Future<void> cacheLanguageCode(String langCode);
}
