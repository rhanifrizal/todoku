import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/domain/repositories/task_repository.dart';

final class GetTasksUsecase implements UseCase<List<TaskEntity>, NoParams> {
  final TaskRepository _repository;

  const GetTasksUsecase(this._repository);

  @override
  Future<(Failure?, List<TaskEntity>?)> call(NoParams params) async {
    return await _repository.getTasks();
  }
}
