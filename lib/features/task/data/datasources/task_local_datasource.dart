import 'package:todoku/features/task/data/models/task_model.dart';

abstract interface class TaskLocalDataSource {
  Future<List<TaskModel>> getCachedTasks();

  Future<void> cacheTask(TaskModel task);

  Future<void> cacheAllTasks(List<TaskModel> tasks);

  Future<void> deleteTask(String id);
}
