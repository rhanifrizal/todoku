import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/task/domain/usecases/create_task.dart';
import 'package:todoku/features/task/domain/usecases/delete_task.dart';
import 'package:todoku/features/task/domain/usecases/get_tasks.dart';
import 'package:todoku/features/task/domain/usecases/update_task.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';
import 'package:todoku/features/task/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks _getTasks;
  final CreateTask _createTask;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;

  TaskBloc({
    required GetTasks getTasks,
    required CreateTask createTask,
    required UpdateTask updateTask,
    required DeleteTask deleteTask,
  }) : _getTasks = getTasks,
       _createTask = createTask,
       _updateTask = updateTask,
       _deleteTask = deleteTask,
       super(const TaskInitialState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<CreateTaskEvent>(_onCreateTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(const TaskLoadingState());
    final (failure, tasks) = await _getTasks(const NoParams());

    if (failure != null) {
      emit(TaskFailureState(errorMessage: failure.message));
    } else if (tasks != null) {
      emit(TaskSuccessState(tasks: tasks));
    }
  }

  Future<void> _onCreateTask(
    CreateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(const TaskLoadingState());
    final (failure, _) = await _createTask(event.task);

    if (failure != null) {
      emit(TaskFailureState(errorMessage: failure.message));
    } else {
      add(const LoadTasksEvent());
    }
  }

  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final (failure, _) = await _updateTask(event.task);

    if (failure != null) {
      emit(TaskFailureState(errorMessage: failure.message));
    } else {
      add(const LoadTasksEvent());
    }
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(const TaskLoadingState());
    final (failure, _) = await _deleteTask(event.id);

    if (failure != null) {
      emit(TaskFailureState(errorMessage: failure.message));
    } else {
      add(const LoadTasksEvent());
    }
  }
}
