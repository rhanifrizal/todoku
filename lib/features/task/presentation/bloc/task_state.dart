import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todoku/core/enums/task/task_category_enum.dart';
import 'package:todoku/core/enums/task/task_priority_enum.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/domain/entities/task_group_entity.dart';

enum TaskStatus { initial, loading, success, failure }

final class TaskState extends Equatable {
  final List<TaskEntity> taskList;
  final List<TaskGroupEntity> groupList;
  final TaskStatus status;
  final String searchQuery;
  final TaskPriority? priorityFilter;
  final TaskCategory? categoryFilter;
  final String? errorMessage;

  const TaskState({
    this.taskList = const [],
    this.groupList = const [],
    this.status = TaskStatus.initial,
    this.searchQuery = '',
    this.priorityFilter,
    this.categoryFilter,
    this.errorMessage,
  });

  TaskState copyWith({
    List<TaskEntity>? taskList,
    List<TaskGroupEntity>? groupList,
    TaskStatus? status,
    String? searchQuery,
    TaskPriority? Function()? priorityFilter,
    TaskCategory? Function()? categoryFilter,
    String? Function()? errorMessage,
  }) {
    return TaskState(
      taskList: taskList ?? this.taskList,
      groupList: groupList ?? this.groupList,
      status: status ?? this.status,
      searchQuery: searchQuery ?? this.searchQuery,
      priorityFilter: priorityFilter != null
          ? priorityFilter()
          : this.priorityFilter,
      categoryFilter: categoryFilter != null
          ? categoryFilter()
          : this.categoryFilter,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  /// Grabs only tasks that DO NOT belong to any groups
  List<TaskEntity> get standaloneTaskList {
    return filteredTaskList.where((task) => task.groupId == null).toList();
  }

  /// Grabs tasks assigned to a specific group
  List<TaskEntity> getGroupTasks(String groupId) {
    return taskList.where((task) => task.groupId == groupId).toList();
  }

  /// Calculates dynamic display metrics for a specific group card (e.g "3/5 Completed")
  String getGroupProgressLabel(BuildContext context, String groupId) {
    final groupTasks = getGroupTasks(groupId);
    if (groupTasks.isEmpty) return "0 ${context.l10n.task}";
    final completedCount = groupTasks.where((task) => task.isCompleted).length;
    return "$completedCount / ${groupTasks.length} ${context.l10n.task}";
  }

  List<TaskEntity> get filteredTaskList {
    if (searchQuery.isEmpty &&
        priorityFilter == null &&
        categoryFilter == null) {
      return taskList;
    }

    return taskList.where((task) {
      bool matchesSearch = true;

      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase().trim();

        if (query.startsWith('#')) {
          /// Tag Search Mode #
          final tagQuery = query.substring(1);
          matchesSearch = task.tags.any(
            (tag) => tag.toLowerCase().contains(tagQuery),
          );
        } else {
          /// Standard Search Mode (Titles and descriptions)
          matchesSearch =
              task.title.toLowerCase().contains(query) ||
              task.description.toLowerCase().contains(query);
        }
      }

      final matchesPriority =
          priorityFilter == null || task.priority == priorityFilter;

      final matchesCategory =
          categoryFilter == null || task.category == categoryFilter;

      return matchesSearch && matchesPriority && matchesCategory;
    }).toList();
  }

  bool get isInitial => status == TaskStatus.initial;

  bool get isLoading => status == TaskStatus.loading;

  bool get isSuccess => status == TaskStatus.success;

  bool get isFailure => status == TaskStatus.failure;

  @override
  List<Object?> get props => [
    taskList,
    groupList,
    status,
    searchQuery,
    priorityFilter,
    categoryFilter,
    errorMessage,
  ];
}
