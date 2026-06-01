import 'package:json_annotation/json_annotation.dart';
import 'package:todoku/features/task/domain/entities/task_group_entity.dart';

part 'task_group_model.g.dart';

@JsonSerializable()
class TaskGroupModel extends TaskGroupEntity {
  const TaskGroupModel({
    required super.id,
    required super.name,
    super.dueDate,
    required super.isCompleted,
  });

  factory TaskGroupModel.fromJson(Map<String, dynamic> json) =>
      _$TaskGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskGroupModelToJson(this);

  factory TaskGroupModel.fromEntity(TaskGroupEntity entity) {
    return TaskGroupModel(
      id: entity.id,
      name: entity.name,
      dueDate: entity.dueDate,
      isCompleted: entity.isCompleted,
    );
  }
}
