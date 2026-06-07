import 'package:todoku/features/task/data/models/task_group_model.dart';
import 'package:todoku/features/task/data/models/task_model.dart';

abstract interface class TaskLocalDataSource {
  Future<List<TaskModel>> getCachedTasks();

  Future<void> cacheTask(TaskModel task);

  Future<void> cacheAllTasks(List<TaskModel> tasks);

  Future<void> deleteTask(String id);

  Future<List<TaskGroupModel>> getGroups();

  Future<TaskGroupModel> cachedGroup(TaskGroupModel group);

  Future<void> updateGroup(TaskGroupModel group);

  Future<void> deleteGroup(String groupId);
}
