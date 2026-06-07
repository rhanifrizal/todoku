import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/task/domain/repositories/task_repository.dart';

final class DeleteGroupUsecase implements UseCase<void, String> {
  final TaskRepository _repository;

  const DeleteGroupUsecase(this._repository);

  @override
  Future<(Failure?, bool?)> call(String groupId) async {
    return await _repository.deleteGroup(groupId);
  }
}
