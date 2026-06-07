import 'package:drift/drift.dart';
import 'package:todoku/core/database/secure_database.dart';
import 'package:todoku/features/task/data/datasources/task_local_datasource.dart';
import 'package:todoku/features/task/data/models/task_group_model.dart';
import 'package:todoku/features/task/data/models/task_model.dart';

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
        priority: row.priority,
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
            priority: task.priority,
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
            priority: task.priority,
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

  @override
  Future<List<TaskGroupModel>> getGroups() async {
    final query = _db.select(_db.taskGroupsTable)
      ..orderBy([
        (tg) => OrderingTerm(expression: tg.name, mode: OrderingMode.asc),
      ]);

    final rows = await query.get();

    return rows.map((row) {
      return TaskGroupModel(
        id: row.id,
        name: row.name,
        dueDate: row.dueDate,
        isCompleted: row.isCompleted,
      );
    }).toList();
  }

  @override
  Future<TaskGroupModel> cachedGroup(TaskGroupModel group) async {
    await _db
        .into(_db.taskGroupsTable)
        .insertOnConflictUpdate(
          TaskGroupsTableCompanion.insert(
            id: group.id,
            name: group.name,
            dueDate: Value(group.dueDate),
            isCompleted: Value(group.isCompleted),
          ),
        );

    return group;
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    final statement = _db.delete(_db.taskGroupsTable)
      ..where((tg) => tg.id.equals(groupId));
    await statement.go();
  }

  @override
  Future<void> updateGroup(TaskGroupModel group) async {
    final statement = _db.update(_db.taskGroupsTable)
      ..where((tg) => tg.id.equals(group.id));

    await statement.write(
      TaskGroupsTableCompanion(
        name: Value(group.name),
        dueDate: Value(group.dueDate),
        isCompleted: Value(group.isCompleted),
      ),
    );
  }
}
