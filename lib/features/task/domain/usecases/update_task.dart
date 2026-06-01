import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/domain/repositories/task_repository.dart';

final class UpdateTask implements UseCase<TaskEntity, TaskEntity> {
  final TaskRepository _repository;

  const UpdateTask(this._repository);

  @override
  Future<(Failure?, TaskEntity?)> call(TaskEntity task) async {
    return await _repository.updateTask(task);
  }
}
