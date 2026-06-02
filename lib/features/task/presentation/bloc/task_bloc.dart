import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/task/domain/usecases/create_task_usecase.dart';
import 'package:todoku/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:todoku/features/task/domain/usecases/get_tasks_usecase.dart';
import 'package:todoku/features/task/domain/usecases/update_task_usecase.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';
import 'package:todoku/features/task/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUsecase _getTasksUsecase;
  final CreateTaskUsecase _createTaskUsecase;
  final UpdateTaskUsecase _updateTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;

  TaskBloc({
    required GetTasksUsecase getTasksUsecase,
    required CreateTaskUsecase createTaskUsecase,
    required UpdateTaskUsecase updateTaskUsecase,
    required DeleteTaskUsecase deleteTaskUsecase,
  }) : _getTasksUsecase = getTasksUsecase,
       _createTaskUsecase = createTaskUsecase,
       _updateTaskUsecase = updateTaskUsecase,
       _deleteTaskUsecase = deleteTaskUsecase,
       super(const TaskState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<CreateTaskEvent>(_onCreateTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading, errorMessage: () => null));
    final (failure, taskList) = await _getTasksUsecase(const NoParams());

    if (failure != null) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: () => failure.message,
        ),
      );
    } else if (taskList != null) {
      emit(
        state.copyWith(
          status: TaskStatus.success,
          taskList: taskList,
          errorMessage: () => null,
        ),
      );
    }
  }

  Future<void> _onCreateTask(
    CreateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading, errorMessage: () => null));
    final (failure, _) = await _createTaskUsecase(event.task);

    if (failure != null) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: () => failure.message,
        ),
      );
    } else {
      add(const LoadTasksEvent());
    }
  }

  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final (failure, _) = await _updateTaskUsecase(event.task);

    if (failure != null) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: () => failure.message,
        ),
      );
    } else {
      add(const LoadTasksEvent());
    }
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading, errorMessage: () => null));
    final (failure, _) = await _deleteTaskUsecase(event.id);

    if (failure != null) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: () => failure.message,
        ),
      );
    } else {
      add(const LoadTasksEvent());
    }
  }
}
