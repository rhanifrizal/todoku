import 'package:todoku/core/errors/failures.dart';
import 'package:todoku/features/task/data/datasources/task_local_datasource.dart';
import 'package:todoku/features/task/data/models/task_group_model.dart';
import 'package:todoku/features/task/data/models/task_model.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/domain/entities/task_group_entity.dart';
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

  @override
  Future<(Failure?, List<TaskGroupEntity>?)> getGroups() async {
    try {
      final groupModel = await _localDataSource.getGroups();
      return (null, groupModel);
    } catch (e) {
      return (
        CacheFailure("Failed to load task groups: ${e.toString()}"),
        null,
      );
    }
  }

  @override
  Future<(Failure?, TaskGroupEntity?)> createGroup(
    TaskGroupEntity group,
  ) async {
    try {
      final modelToCache = TaskGroupModel.fromEntity(group);
      final savedModel = await _localDataSource.cachedGroup(modelToCache);
      return (null, savedModel);
    } catch (e) {
      return (CacheFailure('Failed to save new group: ${e.toString()}'), null);
    }
  }

  @override
  Future<(Failure?, bool success)> deleteGroup(String groupId) async {
    try {
      await _localDataSource.deleteGroup(groupId);
      return (null, true);
    } catch (e) {
      return (
        CacheFailure('Failed to delete group entry: ${e.toString()}'),
        false,
      );
    }
  }

  @override
  Future<(Failure?, TaskGroupEntity?)> updateGroup(
    TaskGroupEntity group,
  ) async {
    try {
      final groupModel = TaskGroupModel.fromEntity(group);
      await _localDataSource.updateGroup(groupModel);
      return (null, group);
    } catch (e) {
      return (
        CacheFailure(
          'Failed to update encrypted group database: ${e.toString()}',
        ),
        null,
      );
    }
  }
}
