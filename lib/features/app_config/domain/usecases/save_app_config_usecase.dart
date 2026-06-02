import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/app_config/domain/repositories/config_repository.dart';

final class SaveAppConfigUsecase implements UseCase<bool, SaveConfigParams> {
  final ConfigRepository _repository;

  const SaveAppConfigUsecase(this._repository);

  @override
  Future<(Failure?, bool?)> call(SaveConfigParams params) async {
    return await switch (params.type) {
      ConfigType.theme => _repository.setThemeMode(params.value),
      ConfigType.language => _repository.setLanguageCode(params.value),
    };
  }
}

enum ConfigType { theme, language }

class SaveConfigParams {
  final ConfigType type;
  final String value;

  const SaveConfigParams({required this.type, required this.value});
}
