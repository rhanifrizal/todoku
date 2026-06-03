import 'package:equatable/equatable.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';

enum TaskStatus { initial, loading, success, failure }

final class TaskState extends Equatable {
  final List<TaskEntity> taskList;
  final TaskStatus status;
  final String searchQuery;
  final TaskPriority? priorityFilter;
  final String? errorMessage;

  const TaskState({
    this.taskList = const [],
    this.status = TaskStatus.initial,
    this.searchQuery = '',
    this.priorityFilter,
    this.errorMessage,
  });

  TaskState copyWith({
    List<TaskEntity>? taskList,
    TaskStatus? status,
    String? searchQuery,
    TaskPriority? Function()? priorityFilter,
    String? Function()? errorMessage,
  }) {
    return TaskState(
      taskList: taskList ?? this.taskList,
      status: status ?? this.status,
      searchQuery: searchQuery ?? this.searchQuery,
      priorityFilter: priorityFilter != null
          ? priorityFilter()
          : this.priorityFilter,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  List<TaskEntity> get filteredTaskList {
    if (searchQuery.isEmpty && priorityFilter == null) {
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
      return matchesSearch && matchesPriority;
    }).toList();
  }

  bool get isInitial => status == TaskStatus.initial;

  bool get isLoading => status == TaskStatus.loading;

  bool get isSuccess => status == TaskStatus.success;

  bool get isFailure => status == TaskStatus.failure;

  @override
  List<Object?> get props => [
    taskList,
    status,
    searchQuery,
    priorityFilter,
    errorMessage,
  ];
}
