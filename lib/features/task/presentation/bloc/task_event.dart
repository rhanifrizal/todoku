import 'package:equatable/equatable.dart';
import 'package:todoku/core/enums/task_category_enum.dart';
import 'package:todoku/core/enums/task_priority_enum.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when the UI mounts to load encrypted records from local storage
final class LoadTasksEvent extends TaskEvent {
  const LoadTasksEvent();
}

/// Triggered when a user creates a new task item
final class CreateTaskEvent extends TaskEvent {
  final TaskEntity task;

  const CreateTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

/// Triggered when toggling completion status or modifying details
final class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

/// Triggered when a user deletes a task item
final class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent(this.id);

  @override
  List<Object?> get props => [id];
}

/// Triggered when a user searching for a task
final class FilterTasksEvent extends TaskEvent {
  final String searchQuery;
  final TaskPriority? priorityFilter;
  final TaskCategory? categoryFilter;

  const FilterTasksEvent({
    this.searchQuery = '',
    this.priorityFilter,
    this.categoryFilter,
  });

  @override
  List<Object?> get props => [searchQuery, priorityFilter, categoryFilter];
}
