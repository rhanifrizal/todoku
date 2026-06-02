import 'package:drift/drift.dart';
import 'package:todoku/core/database/secure_database.dart';
import 'package:todoku/features/task/data/datasources/task_local_datasource.dart';
import 'package:todoku/features/task/data/models/task_model.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';

final class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final SecureDatabase _db;

  const TaskLocalDataSourceImpl({required SecureDatabase db}) : _db = db;

  @override
  Future<List<TaskModel>> getCachedTasks() async {
    final query = _db.select(_db.tasksTable)
      ..orderBy([
        (t) => OrderingTerm(expression: t.dateStart, mode: OrderingMode.desc),
      ]);

    final rows = await query.get();

    return rows.map((row) {
      return TaskModel(
        id: row.id,
        title: row.title,
        description: row.description,
        isCompleted: row.isCompleted,
        dateStart: row.dateStart,
        dueDate: row.dueDate,
        tags: row.tags,
        category: row.category,
        priority: TaskPriority.values.byName(row.priority),
        groupId: row.groupId,
      );
    }).toList();
  }

  @override
  Future<void> cacheTask(TaskModel task) async {
    await _db
        .into(_db.tasksTable)
        .insertOnConflictUpdate(
          TasksTableCompanion.insert(
            id: task.id,
            title: task.title,
            description: task.description,
            isCompleted: Value(task.isCompleted),
            dateStart: task.dateStart,
            dueDate: Value(task.dueDate),
            tags: task.tags,
            category: Value(task.category),
            priority: task.priority.name,
            groupId: Value(task.groupId),
          ),
        );
  }

  @override
  Future<void> cacheAllTasks(List<TaskModel> tasks) async {
    await _db.batch((batch) {
      for (final task in tasks) {
        batch.insert(
          _db.tasksTable,
          TasksTableCompanion.insert(
            id: task.id,
            title: task.title,
            description: task.description,
            isCompleted: Value(task.isCompleted),
            dateStart: task.dateStart,
            dueDate: Value(task.dueDate),
            tags: task.tags,
            category: Value(task.category),
            priority: task.priority.name,
            groupId: Value(task.groupId),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  @override
  Future<void> deleteTask(String id) async {
    final statement = _db.delete(_db.tasksTable)..where((t) => t.id.equals(id));
    await statement.go();
  }
}
