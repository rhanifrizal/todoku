import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';

abstract interface class TaskRepository {
  Future<(Failure?, List<TaskEntity>?)> getTasks();

  Future<(Failure?, TaskEntity?)> createTask(TaskEntity task);

  Future<(Failure?, TaskEntity?)> updateTask(TaskEntity task);

  Future<(Failure?, bool success)> deleteTask(String id);
}
