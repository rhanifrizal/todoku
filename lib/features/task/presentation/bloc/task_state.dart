import 'package:equatable/equatable.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the widget tree is first building
final class TaskInitialState extends TaskState {
  const TaskInitialState();
}

/// Visual block state used to show loading spinners during disk processing
final class TaskLoadingState extends TaskState {
  const TaskLoadingState();
}

/// State emitted when task actions execute flawlessly, delivering updated datasets
final class TaskSuccessState extends TaskState {
  final List<TaskEntity> tasks;

  const TaskSuccessState({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

/// State emitted when cryptographic keys fail or storage operations throw an exception
final class TaskFailureState extends TaskState {
  final String errorMessage;

  const TaskFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
