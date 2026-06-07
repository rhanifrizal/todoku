import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/task/domain/entities/task_group_entity.dart';
import 'package:todoku/features/task/domain/repositories/task_repository.dart';

class GetGroupsUsecase implements UseCase<List<TaskGroupEntity>, NoParams> {
  final TaskRepository _repository;

  const GetGroupsUsecase(this._repository);

  @override
  Future<(Failure?, List<TaskGroupEntity>?)> call(NoParams params) async {
    return await _repository.getGroups();
  }
}
