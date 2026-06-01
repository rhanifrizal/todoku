// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskGroupModel _$TaskGroupModelFromJson(Map<String, dynamic> json) =>
    TaskGroupModel(
      id: json['id'] as String,
      name: json['name'] as String,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$TaskGroupModelToJson(TaskGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dueDate': instance.dueDate?.toIso8601String(),
      'isCompleted': instance.isCompleted,
    };
