import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/features/app_config/data/datasources/config_local_datasource.dart';
import 'package:todoku/features/app_config/domain/repositories/config_repository.dart';
import 'package:todoku/features/app_config/domain/usecases/get_app_config_usecase.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  final ConfigLocalDataSource _localDataSource;

  const ConfigRepositoryImpl({required ConfigLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<(Failure?, AppConfigPayload?)> getAppConfig() async {
    try {
      final theme = await _localDataSource.getThemeMode();
      final lang = await _localDataSource.getLanguageCode();

      return (
        null,
        AppConfigPayload(
          themeMode: theme ?? 'system',
          languageCode: lang ?? 'en',
        ),
      );
    } catch (e) {
      return (
        CacheFailure(
          'Failed to load app configuration properties: ${e.toString()}',
        ),
        null,
      );
    }
  }

  @override
  Future<(Failure?, bool?)> setThemeMode(String theme) async {
    try {
      await _localDataSource.cacheThemeMode(theme);
      return (null, true);
    } catch (e) {
      return (
        CacheFailure('Failed to save theme properties: ${e.toString()}'),
        null,
      );
    }
  }

  @override
  Future<(Failure?, bool?)> setLanguageCode(String langCode) async {
    try {
      await _localDataSource.cacheLanguageCode(langCode);
      return (null, true);
    } catch (e) {
      return (
        CacheFailure('Failed to save language properties: ${e.toString()}'),
        null,
      );
    }
  }
}
