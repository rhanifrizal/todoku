import 'package:drift/drift.dart';
import 'package:todoku/core/database/secure_database.dart';
import 'package:todoku/core/database/tables/task_groups_table.dart';
import 'package:todoku/core/enums/task/task_category_enum.dart';
import 'package:todoku/core/enums/task/task_priority_enum.dart';

class TasksTable extends Table {
  TextColumn get id => text()();

  TextColumn get title => text().withLength(min: 1, max: 255)();

  TextColumn get description => text()();

  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get dateStart => dateTime()();

  DateTimeColumn get dueDate => dateTime().nullable()();

  TextColumn get tags => text().map(const ListStringConverter())();

  TextColumn get category =>
      text().map(const EnumNameConverter(TaskCategory.values)).nullable()();

  TextColumn get priority =>
      text().map(const EnumNameConverter(TaskPriority.values))();

  TextColumn get groupId => text().nullable().references(
    TaskGroupsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  @override
  Set<Column> get primaryKey => {id};
}
