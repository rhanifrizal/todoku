import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/task/domain/repositories/task_repository.dart';

final class DeleteTask implements UseCase<bool, String> {
  final TaskRepository _repository;

  const DeleteTask(this._repository);

  @override
  Future<(Failure?, bool?)> call(String id) async {
    return await _repository.deleteTask(id);
  }
}
