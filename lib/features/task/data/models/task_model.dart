import 'package:json_annotation/json_annotation.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/core/enums/task/task_category_enum.dart';
import 'package:todoku/core/enums/task/task_priority_enum.dart';

part 'task_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
    required super.dateStart,
    super.dueDate,
    required super.tags,
    super.category,
    required super.priority,
    super.groupId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      dateStart: entity.dateStart,
      dueDate: entity.dueDate,
      tags: entity.tags,
      category: entity.category,
      priority: entity.priority,
      groupId: entity.groupId,
    );
  }
}
