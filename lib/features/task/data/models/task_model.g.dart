// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
      dateStart: DateTime.parse(json['dateStart'] as String),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      category: $enumDecodeNullable(_$TaskCategoryEnumMap, json['category']),
      priority: $enumDecode(_$TaskPriorityEnumMap, json['priority']),
      groupId: json['groupId'] as String?,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'dateStart': instance.dateStart.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'tags': instance.tags,
      'category': _$TaskCategoryEnumMap[instance.category],
      'priority': _$TaskPriorityEnumMap[instance.priority]!,
      'groupId': instance.groupId,
    };

const _$TaskCategoryEnumMap = {
  TaskCategory.personal: 'personal',
  TaskCategory.work: 'work',
  TaskCategory.shopping: 'shopping',
  TaskCategory.health: 'health',
  TaskCategory.finance: 'finance',
};

const _$TaskPriorityEnumMap = {
  TaskPriority.low: 'low',
  TaskPriority.medium: 'medium',
  TaskPriority.high: 'high',
};
