// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_database.dart';

// ignore_for_file: type=lint
class $TaskGroupsTableTable extends TaskGroupsTable
    with TableInfo<$TaskGroupsTableTable, TaskGroupsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskGroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, name, dueDate, isCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_groups_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TaskGroupsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskGroupsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskGroupsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
    );
  }

  @override
  $TaskGroupsTableTable createAlias(String alias) {
    return $TaskGroupsTableTable(attachedDatabase, alias);
  }
}

class TaskGroupsTableData extends DataClass
    implements Insertable<TaskGroupsTableData> {
  final String id;
  final String name;
  final DateTime? dueDate;
  final bool isCompleted;
  const TaskGroupsTableData(
      {required this.id,
      required this.name,
      this.dueDate,
      required this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  TaskGroupsTableCompanion toCompanion(bool nullToAbsent) {
    return TaskGroupsTableCompanion(
      id: Value(id),
      name: Value(name),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      isCompleted: Value(isCompleted),
    );
  }

  factory TaskGroupsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskGroupsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  TaskGroupsTableData copyWith(
          {String? id,
          String? name,
          Value<DateTime?> dueDate = const Value.absent(),
          bool? isCompleted}) =>
      TaskGroupsTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  TaskGroupsTableData copyWithCompanion(TaskGroupsTableCompanion data) {
    return TaskGroupsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskGroupsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, dueDate, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskGroupsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.dueDate == this.dueDate &&
          other.isCompleted == this.isCompleted);
}

class TaskGroupsTableCompanion extends UpdateCompanion<TaskGroupsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime?> dueDate;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const TaskGroupsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskGroupsTableCompanion.insert({
    required String id,
    required String name,
    this.dueDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<TaskGroupsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? dueDate,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (dueDate != null) 'due_date': dueDate,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskGroupsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<DateTime?>? dueDate,
      Value<bool>? isCompleted,
      Value<int>? rowid}) {
    return TaskGroupsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskGroupsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTableTable extends TasksTable
    with TableInfo<$TasksTableTable, TasksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _dateStartMeta =
      const VerificationMeta('dateStart');
  @override
  late final GeneratedColumn<DateTime> dateStart = GeneratedColumn<DateTime>(
      'date_start', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> tags =
      GeneratedColumn<String>('tags', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($TasksTableTable.$convertertags);
  @override
  late final GeneratedColumnWithTypeConverter<TaskCategory?, String> category =
      GeneratedColumn<String>('category', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<TaskCategory?>($TasksTableTable.$convertercategoryn);
  @override
  late final GeneratedColumnWithTypeConverter<TaskPriority, String> priority =
      GeneratedColumn<String>('priority', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TaskPriority>($TasksTableTable.$converterpriority);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES task_groups_table (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        isCompleted,
        dateStart,
        dueDate,
        tags,
        category,
        priority,
        groupId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks_table';
  @override
  VerificationContext validateIntegrity(Insertable<TasksTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('date_start')) {
      context.handle(_dateStartMeta,
          dateStart.isAcceptableOrUnknown(data['date_start']!, _dateStartMeta));
    } else if (isInserting) {
      context.missing(_dateStartMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TasksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TasksTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      dateStart: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_start'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      tags: $TasksTableTable.$convertertags.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!),
      category: $TasksTableTable.$convertercategoryn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])),
      priority: $TasksTableTable.$converterpriority.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!),
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id']),
    );
  }

  @override
  $TasksTableTable createAlias(String alias) {
    return $TasksTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertertags =
      const ListStringConverter();
  static JsonTypeConverter2<TaskCategory, String, String> $convertercategory =
      const EnumNameConverter(TaskCategory.values);
  static JsonTypeConverter2<TaskCategory?, String?, String?>
      $convertercategoryn = JsonTypeConverter2.asNullable($convertercategory);
  static JsonTypeConverter2<TaskPriority, String, String> $converterpriority =
      const EnumNameConverter(TaskPriority.values);
}

class TasksTableData extends DataClass implements Insertable<TasksTableData> {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime dateStart;
  final DateTime? dueDate;
  final List<String> tags;
  final TaskCategory? category;
  final TaskPriority priority;
  final String? groupId;
  const TasksTableData(
      {required this.id,
      required this.title,
      required this.description,
      required this.isCompleted,
      required this.dateStart,
      this.dueDate,
      required this.tags,
      this.category,
      required this.priority,
      this.groupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['date_start'] = Variable<DateTime>(dateStart);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    {
      map['tags'] =
          Variable<String>($TasksTableTable.$convertertags.toSql(tags));
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(
          $TasksTableTable.$convertercategoryn.toSql(category));
    }
    {
      map['priority'] =
          Variable<String>($TasksTableTable.$converterpriority.toSql(priority));
    }
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    return map;
  }

  TasksTableCompanion toCompanion(bool nullToAbsent) {
    return TasksTableCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      isCompleted: Value(isCompleted),
      dateStart: Value(dateStart),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      tags: Value(tags),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      priority: Value(priority),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
    );
  }

  factory TasksTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TasksTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      dateStart: serializer.fromJson<DateTime>(json['dateStart']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      tags: serializer.fromJson<List<String>>(json['tags']),
      category: $TasksTableTable.$convertercategoryn
          .fromJson(serializer.fromJson<String?>(json['category'])),
      priority: $TasksTableTable.$converterpriority
          .fromJson(serializer.fromJson<String>(json['priority'])),
      groupId: serializer.fromJson<String?>(json['groupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'dateStart': serializer.toJson<DateTime>(dateStart),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'tags': serializer.toJson<List<String>>(tags),
      'category': serializer.toJson<String?>(
          $TasksTableTable.$convertercategoryn.toJson(category)),
      'priority': serializer
          .toJson<String>($TasksTableTable.$converterpriority.toJson(priority)),
      'groupId': serializer.toJson<String?>(groupId),
    };
  }

  TasksTableData copyWith(
          {String? id,
          String? title,
          String? description,
          bool? isCompleted,
          DateTime? dateStart,
          Value<DateTime?> dueDate = const Value.absent(),
          List<String>? tags,
          Value<TaskCategory?> category = const Value.absent(),
          TaskPriority? priority,
          Value<String?> groupId = const Value.absent()}) =>
      TasksTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
        dateStart: dateStart ?? this.dateStart,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        tags: tags ?? this.tags,
        category: category.present ? category.value : this.category,
        priority: priority ?? this.priority,
        groupId: groupId.present ? groupId.value : this.groupId,
      );
  TasksTableData copyWithCompanion(TasksTableCompanion data) {
    return TasksTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      dateStart: data.dateStart.present ? data.dateStart.value : this.dateStart,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      tags: data.tags.present ? data.tags.value : this.tags,
      category: data.category.present ? data.category.value : this.category,
      priority: data.priority.present ? data.priority.value : this.priority,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TasksTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('dateStart: $dateStart, ')
          ..write('dueDate: $dueDate, ')
          ..write('tags: $tags, ')
          ..write('category: $category, ')
          ..write('priority: $priority, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, isCompleted,
      dateStart, dueDate, tags, category, priority, groupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TasksTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.isCompleted == this.isCompleted &&
          other.dateStart == this.dateStart &&
          other.dueDate == this.dueDate &&
          other.tags == this.tags &&
          other.category == this.category &&
          other.priority == this.priority &&
          other.groupId == this.groupId);
}

class TasksTableCompanion extends UpdateCompanion<TasksTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<bool> isCompleted;
  final Value<DateTime> dateStart;
  final Value<DateTime?> dueDate;
  final Value<List<String>> tags;
  final Value<TaskCategory?> category;
  final Value<TaskPriority> priority;
  final Value<String?> groupId;
  final Value<int> rowid;
  const TasksTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.dateStart = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.tags = const Value.absent(),
    this.category = const Value.absent(),
    this.priority = const Value.absent(),
    this.groupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksTableCompanion.insert({
    required String id,
    required String title,
    required String description,
    this.isCompleted = const Value.absent(),
    required DateTime dateStart,
    this.dueDate = const Value.absent(),
    required List<String> tags,
    this.category = const Value.absent(),
    required TaskPriority priority,
    this.groupId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        description = Value(description),
        dateStart = Value(dateStart),
        tags = Value(tags),
        priority = Value(priority);
  static Insertable<TasksTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<bool>? isCompleted,
    Expression<DateTime>? dateStart,
    Expression<DateTime>? dueDate,
    Expression<String>? tags,
    Expression<String>? category,
    Expression<String>? priority,
    Expression<String>? groupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (dateStart != null) 'date_start': dateStart,
      if (dueDate != null) 'due_date': dueDate,
      if (tags != null) 'tags': tags,
      if (category != null) 'category': category,
      if (priority != null) 'priority': priority,
      if (groupId != null) 'group_id': groupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? description,
      Value<bool>? isCompleted,
      Value<DateTime>? dateStart,
      Value<DateTime?>? dueDate,
      Value<List<String>>? tags,
      Value<TaskCategory?>? category,
      Value<TaskPriority>? priority,
      Value<String?>? groupId,
      Value<int>? rowid}) {
    return TasksTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dateStart: dateStart ?? this.dateStart,
      dueDate: dueDate ?? this.dueDate,
      tags: tags ?? this.tags,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      groupId: groupId ?? this.groupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (dateStart.present) {
      map['date_start'] = Variable<DateTime>(dateStart.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (tags.present) {
      map['tags'] =
          Variable<String>($TasksTableTable.$convertertags.toSql(tags.value));
    }
    if (category.present) {
      map['category'] = Variable<String>(
          $TasksTableTable.$convertercategoryn.toSql(category.value));
    }
    if (priority.present) {
      map['priority'] = Variable<String>(
          $TasksTableTable.$converterpriority.toSql(priority.value));
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('dateStart: $dateStart, ')
          ..write('dueDate: $dueDate, ')
          ..write('tags: $tags, ')
          ..write('category: $category, ')
          ..write('priority: $priority, ')
          ..write('groupId: $groupId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$SecureDatabase extends GeneratedDatabase {
  _$SecureDatabase(QueryExecutor e) : super(e);
  $SecureDatabaseManager get managers => $SecureDatabaseManager(this);
  late final $TaskGroupsTableTable taskGroupsTable =
      $TaskGroupsTableTable(this);
  late final $TasksTableTable tasksTable = $TasksTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [taskGroupsTable, tasksTable];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('task_groups_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('tasks_table', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$TaskGroupsTableTableCreateCompanionBuilder = TaskGroupsTableCompanion
    Function({
  required String id,
  required String name,
  Value<DateTime?> dueDate,
  Value<bool> isCompleted,
  Value<int> rowid,
});
typedef $$TaskGroupsTableTableUpdateCompanionBuilder = TaskGroupsTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<DateTime?> dueDate,
  Value<bool> isCompleted,
  Value<int> rowid,
});

final class $$TaskGroupsTableTableReferences extends BaseReferences<
    _$SecureDatabase, $TaskGroupsTableTable, TaskGroupsTableData> {
  $$TaskGroupsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TasksTableTable, List<TasksTableData>>
      _tasksTableRefsTable(_$SecureDatabase db) =>
          MultiTypedResultKey.fromTable(db.tasksTable,
              aliasName: $_aliasNameGenerator(
                  db.taskGroupsTable.id, db.tasksTable.groupId));

  $$TasksTableTableProcessedTableManager get tasksTableRefs {
    final manager = $$TasksTableTableTableManager($_db, $_db.tasksTable)
        .filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TaskGroupsTableTableFilterComposer
    extends Composer<_$SecureDatabase, $TaskGroupsTableTable> {
  $$TaskGroupsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  Expression<bool> tasksTableRefs(
      Expression<bool> Function($$TasksTableTableFilterComposer f) f) {
    final $$TasksTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tasksTable,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableTableFilterComposer(
              $db: $db,
              $table: $db.tasksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TaskGroupsTableTableOrderingComposer
    extends Composer<_$SecureDatabase, $TaskGroupsTableTable> {
  $$TaskGroupsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));
}

class $$TaskGroupsTableTableAnnotationComposer
    extends Composer<_$SecureDatabase, $TaskGroupsTableTable> {
  $$TaskGroupsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  Expression<T> tasksTableRefs<T extends Object>(
      Expression<T> Function($$TasksTableTableAnnotationComposer a) f) {
    final $$TasksTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tasksTable,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableTableAnnotationComposer(
              $db: $db,
              $table: $db.tasksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TaskGroupsTableTableTableManager extends RootTableManager<
    _$SecureDatabase,
    $TaskGroupsTableTable,
    TaskGroupsTableData,
    $$TaskGroupsTableTableFilterComposer,
    $$TaskGroupsTableTableOrderingComposer,
    $$TaskGroupsTableTableAnnotationComposer,
    $$TaskGroupsTableTableCreateCompanionBuilder,
    $$TaskGroupsTableTableUpdateCompanionBuilder,
    (TaskGroupsTableData, $$TaskGroupsTableTableReferences),
    TaskGroupsTableData,
    PrefetchHooks Function({bool tasksTableRefs})> {
  $$TaskGroupsTableTableTableManager(
      _$SecureDatabase db, $TaskGroupsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskGroupsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskGroupsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskGroupsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskGroupsTableCompanion(
            id: id,
            name: name,
            dueDate: dueDate,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<DateTime?> dueDate = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskGroupsTableCompanion.insert(
            id: id,
            name: name,
            dueDate: dueDate,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TaskGroupsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({tasksTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tasksTableRefs) db.tasksTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tasksTableRefs)
                    await $_getPrefetchedData<TaskGroupsTableData,
                            $TaskGroupsTableTable, TasksTableData>(
                        currentTable: table,
                        referencedTable: $$TaskGroupsTableTableReferences
                            ._tasksTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TaskGroupsTableTableReferences(db, table, p0)
                                .tasksTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.groupId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TaskGroupsTableTableProcessedTableManager = ProcessedTableManager<
    _$SecureDatabase,
    $TaskGroupsTableTable,
    TaskGroupsTableData,
    $$TaskGroupsTableTableFilterComposer,
    $$TaskGroupsTableTableOrderingComposer,
    $$TaskGroupsTableTableAnnotationComposer,
    $$TaskGroupsTableTableCreateCompanionBuilder,
    $$TaskGroupsTableTableUpdateCompanionBuilder,
    (TaskGroupsTableData, $$TaskGroupsTableTableReferences),
    TaskGroupsTableData,
    PrefetchHooks Function({bool tasksTableRefs})>;
typedef $$TasksTableTableCreateCompanionBuilder = TasksTableCompanion Function({
  required String id,
  required String title,
  required String description,
  Value<bool> isCompleted,
  required DateTime dateStart,
  Value<DateTime?> dueDate,
  required List<String> tags,
  Value<TaskCategory?> category,
  required TaskPriority priority,
  Value<String?> groupId,
  Value<int> rowid,
});
typedef $$TasksTableTableUpdateCompanionBuilder = TasksTableCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> description,
  Value<bool> isCompleted,
  Value<DateTime> dateStart,
  Value<DateTime?> dueDate,
  Value<List<String>> tags,
  Value<TaskCategory?> category,
  Value<TaskPriority> priority,
  Value<String?> groupId,
  Value<int> rowid,
});

final class $$TasksTableTableReferences
    extends BaseReferences<_$SecureDatabase, $TasksTableTable, TasksTableData> {
  $$TasksTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TaskGroupsTableTable _groupIdTable(_$SecureDatabase db) =>
      db.taskGroupsTable.createAlias(
          $_aliasNameGenerator(db.tasksTable.groupId, db.taskGroupsTable.id));

  $$TaskGroupsTableTableProcessedTableManager? get groupId {
    final $_column = $_itemColumn<String>('group_id');
    if ($_column == null) return null;
    final manager =
        $$TaskGroupsTableTableTableManager($_db, $_db.taskGroupsTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TasksTableTableFilterComposer
    extends Composer<_$SecureDatabase, $TasksTableTable> {
  $$TasksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateStart => $composableBuilder(
      column: $table.dateStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String> get tags =>
      $composableBuilder(
          column: $table.tags,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<TaskCategory?, TaskCategory, String>
      get category => $composableBuilder(
          column: $table.category,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<TaskPriority, TaskPriority, String>
      get priority => $composableBuilder(
          column: $table.priority,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$TaskGroupsTableTableFilterComposer get groupId {
    final $$TaskGroupsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.taskGroupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskGroupsTableTableFilterComposer(
              $db: $db,
              $table: $db.taskGroupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableTableOrderingComposer
    extends Composer<_$SecureDatabase, $TasksTableTable> {
  $$TasksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateStart => $composableBuilder(
      column: $table.dateStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  $$TaskGroupsTableTableOrderingComposer get groupId {
    final $$TaskGroupsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.taskGroupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskGroupsTableTableOrderingComposer(
              $db: $db,
              $table: $db.taskGroupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableTableAnnotationComposer
    extends Composer<_$SecureDatabase, $TasksTableTable> {
  $$TasksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<DateTime> get dateStart =>
      $composableBuilder(column: $table.dateStart, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TaskCategory?, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TaskPriority, String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  $$TaskGroupsTableTableAnnotationComposer get groupId {
    final $$TaskGroupsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.taskGroupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskGroupsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.taskGroupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableTableTableManager extends RootTableManager<
    _$SecureDatabase,
    $TasksTableTable,
    TasksTableData,
    $$TasksTableTableFilterComposer,
    $$TasksTableTableOrderingComposer,
    $$TasksTableTableAnnotationComposer,
    $$TasksTableTableCreateCompanionBuilder,
    $$TasksTableTableUpdateCompanionBuilder,
    (TasksTableData, $$TasksTableTableReferences),
    TasksTableData,
    PrefetchHooks Function({bool groupId})> {
  $$TasksTableTableTableManager(_$SecureDatabase db, $TasksTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime> dateStart = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<List<String>> tags = const Value.absent(),
            Value<TaskCategory?> category = const Value.absent(),
            Value<TaskPriority> priority = const Value.absent(),
            Value<String?> groupId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TasksTableCompanion(
            id: id,
            title: title,
            description: description,
            isCompleted: isCompleted,
            dateStart: dateStart,
            dueDate: dueDate,
            tags: tags,
            category: category,
            priority: priority,
            groupId: groupId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String description,
            Value<bool> isCompleted = const Value.absent(),
            required DateTime dateStart,
            Value<DateTime?> dueDate = const Value.absent(),
            required List<String> tags,
            Value<TaskCategory?> category = const Value.absent(),
            required TaskPriority priority,
            Value<String?> groupId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TasksTableCompanion.insert(
            id: id,
            title: title,
            description: description,
            isCompleted: isCompleted,
            dateStart: dateStart,
            dueDate: dueDate,
            tags: tags,
            category: category,
            priority: priority,
            groupId: groupId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TasksTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({groupId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (groupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupId,
                    referencedTable:
                        $$TasksTableTableReferences._groupIdTable(db),
                    referencedColumn:
                        $$TasksTableTableReferences._groupIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TasksTableTableProcessedTableManager = ProcessedTableManager<
    _$SecureDatabase,
    $TasksTableTable,
    TasksTableData,
    $$TasksTableTableFilterComposer,
    $$TasksTableTableOrderingComposer,
    $$TasksTableTableAnnotationComposer,
    $$TasksTableTableCreateCompanionBuilder,
    $$TasksTableTableUpdateCompanionBuilder,
    (TasksTableData, $$TasksTableTableReferences),
    TasksTableData,
    PrefetchHooks Function({bool groupId})>;

class $SecureDatabaseManager {
  final _$SecureDatabase _db;
  $SecureDatabaseManager(this._db);
  $$TaskGroupsTableTableTableManager get taskGroupsTable =>
      $$TaskGroupsTableTableTableManager(_db, _db.taskGroupsTable);
  $$TasksTableTableTableManager get tasksTable =>
      $$TasksTableTableTableManager(_db, _db.tasksTable);
}
