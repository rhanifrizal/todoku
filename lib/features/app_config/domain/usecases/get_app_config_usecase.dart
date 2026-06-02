import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/app_config/domain/repositories/config_repository.dart';

final class GetAppConfigUsecase implements UseCase<AppConfigPayload, NoParams> {
  final ConfigRepository _repository;

  const GetAppConfigUsecase(this._repository);

  @override
  Future<(Failure?, AppConfigPayload?)> call(NoParams params) async {
    return await _repository.getAppConfig();
  }
}

class AppConfigPayload {
  final String themeMode;
  final String languageCode;

  const AppConfigPayload({required this.themeMode, required this.languageCode});
}
