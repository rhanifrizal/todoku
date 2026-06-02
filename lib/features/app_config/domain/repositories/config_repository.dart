import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/features/app_config/domain/usecases/get_app_config_usecase.dart';

abstract interface class ConfigRepository {
  Future<(Failure?, AppConfigPayload?)> getAppConfig();

  Future<(Failure?, bool?)> setThemeMode(String theme);

  Future<(Failure?, bool?)> setLanguageCode(String langCode);
}
