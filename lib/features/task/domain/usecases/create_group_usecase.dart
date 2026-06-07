import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/task/domain/entities/task_group_entity.dart';
import 'package:todoku/features/task/domain/repositories/task_repository.dart';

class CreateGroupUsecase implements UseCase<TaskGroupEntity, TaskGroupEntity> {
  final TaskRepository _repository;

  const CreateGroupUsecase(this._repository);

  @override
  Future<(Failure?, TaskGroupEntity?)> call(TaskGroupEntity group) async {
    return await _repository.createGroup(group);
  }
}
