import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/features/task/data/datasources/task_local_datasource.dart';
import 'package:todoku/features/task/data/models/task_model.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/domain/repositories/task_repository.dart';

final class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource _localDataSource;

  const TaskRepositoryImpl({required TaskLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<(Failure?, List<TaskEntity>?)> getTasks() async {
    try {
      final localModels = await _localDataSource.getCachedTasks();
      return (null, localModels);
    } catch (e) {
      return (
        CacheFailure('Failed to retrieve secure local tasks: ${e.toString()}'),
        null,
      );
    }
  }

  @override
  Future<(Failure?, TaskEntity?)> createTask(TaskEntity task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      await _localDataSource.cacheTask(taskModel);
      return (null, task);
    } catch (e) {
      return (
        CacheFailure('Failed to cryptographically save task: ${e.toString()}'),
        null,
      );
    }
  }

  @override
  Future<(Failure?, TaskEntity?)> updateTask(TaskEntity task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      await _localDataSource.cacheTask(taskModel);
      return (null, task);
    } catch (e) {
      return (
        CacheFailure(
          'Failed to update encrypted task database: ${e.toString()}',
        ),
        null,
      );
    }
  }

  @override
  Future<(Failure?, bool success)> deleteTask(String id) async {
    try {
      await _localDataSource.deleteTask(id);
      return (null, true);
    } catch (e) {
      return (
        CacheFailure('Failed to purge database entry: ${e.toString()}'),
        false,
      );
    }
  }
}
