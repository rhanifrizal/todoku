import 'package:equatable/equatable.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';

enum TaskStatus { initial, loading, success, failure }

final class TaskState extends Equatable {
  final List<TaskEntity> taskList;
  final TaskStatus status;
  final String? errorMessage;

  const TaskState({
    this.taskList = const [],
    this.status = TaskStatus.initial,
    this.errorMessage,
  });

  TaskState copyWith({
    List<TaskEntity>? taskList,
    TaskStatus? status,
    String? Function()? errorMessage,
  }) {
    return TaskState(
      taskList: taskList ?? this.taskList,
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  bool get isInitial => status == TaskStatus.initial;

  bool get isLoading => status == TaskStatus.loading;

  bool get isSuccess => status == TaskStatus.success;

  bool get isFailure => status == TaskStatus.failure;

  @override
  List<Object?> get props => [taskList, status, errorMessage];
}
