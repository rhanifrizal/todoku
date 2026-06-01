import 'package:drift/drift.dart';
import 'package:todoku/core/database/secure_database.dart';

class TasksTable extends Table {
  TextColumn get id => text()();

  TextColumn get title => text().withLength(min: 1, max: 255)();

  TextColumn get description => text()();

  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get dateStart => dateTime()();

  DateTimeColumn get dueDate => dateTime().nullable()();

  TextColumn get tags => text().map(const ListStringConverter())();

  TextColumn get category => text().nullable()();

  TextColumn get priority => text()();

  TextColumn get groupId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
