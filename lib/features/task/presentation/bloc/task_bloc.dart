import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/task/domain/usecases/create_group_usecase.dart';
import 'package:todoku/features/task/domain/usecases/create_task_usecase.dart';
import 'package:todoku/features/task/domain/usecases/delete_group_usecase.dart';
import 'package:todoku/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:todoku/features/task/domain/usecases/get_groups_usecase.dart';
import 'package:todoku/features/task/domain/usecases/get_tasks_usecase.dart';
import 'package:todoku/features/task/domain/usecases/update_group_usecase.dart';
import 'package:todoku/features/task/domain/usecases/update_task_usecase.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';
import 'package:todoku/features/task/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUsecase _getTasksUsecase;
  final CreateTaskUsecase _createTaskUsecase;
  final UpdateTaskUsecase _updateTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;
  final GetGroupsUsecase _getGroupsUsecase;
  final CreateGroupUsecase _createGroupUsecase;
  final UpdateGroupUsecase _updateGroupUsecase;
  final DeleteGroupUsecase _deleteGroupUsecase;

  TaskBloc({
    required GetTasksUsecase getTasksUsecase,
    required CreateTaskUsecase createTaskUsecase,
    required UpdateTaskUsecase updateTaskUsecase,
    required DeleteTaskUsecase deleteTaskUsecase,
    required GetGroupsUsecase getGroupsUsecase,
    required CreateGroupUsecase createGroupUsecase,
    required UpdateGroupUsecase updateGroupUsecase,
    required DeleteGroupUsecase deleteGroupUsecase,
  }) : _getTasksUsecase = getTasksUsecase,
       _createTaskUsecase = createTaskUsecase,
       _updateTaskUsecase = updateTaskUsecase,
       _deleteTaskUsecase = deleteTaskUsecase,
       _getGroupsUsecase = getGroupsUsecase,
       _createGroupUsecase = createGroupUsecase,
       _updateGroupUsecase = updateGroupUsecase,
       _deleteGroupUsecase = deleteGroupUsecase,
       super(const TaskState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<CreateTaskEvent>(_onCreateTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<FilterTasksEvent>(_onFilterTasks);
    on<LoadGroupEvent>(_onLoadGroup);
    on<CreateGroupEvent>(_onCreateGroup);
    on<UpdateGroupEvent>(_onUpdateGroup);
    on<DeleteGroupEvent>(_onDeleteGroup);
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

  void _onFilterTasks(FilterTasksEvent event, Emitter<TaskState> emit) {
    emit(
      state.copyWith(
        searchQuery: event.searchQuery,
        priorityFilter: () => event.priorityFilter,
        categoryFilter: () => event.categoryFilter,
      ),
    );
  }

  Future<void> _onLoadGroup(
    LoadGroupEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading, errorMessage: () => null));
    final (failure, groupList) = await _getGroupsUsecase(const NoParams());

    if (failure != null) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: () => failure.message,
        ),
      );
    } else if (groupList != null) {
      emit(
        state.copyWith(
          status: TaskStatus.success,
          groupList: groupList,
          errorMessage: () => null,
        ),
      );
    }
  }

  Future<void> _onCreateGroup(
    CreateGroupEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading, errorMessage: () => null));
    final (failure, _) = await _createGroupUsecase(event.group);

    if (failure != null) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: () => failure.message,
        ),
      );
    } else {
      add(const LoadGroupEvent());
    }
  }

  Future<void> _onUpdateGroup(
    UpdateGroupEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading, errorMessage: () => null));
    final (failure, _) = await _updateGroupUsecase(event.group);

    if (failure != null) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: () => failure.message,
        ),
      );
    } else {
      add(const LoadGroupEvent());
    }
  }

  Future<void> _onDeleteGroup(
    DeleteGroupEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading, errorMessage: () => null));
    final (failure, _) = await _deleteGroupUsecase(event.groupId);

    if (failure != null) {
      emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: () => failure.message,
        ),
      );
    } else {
      add(const LoadGroupEvent());
      add(const LoadTasksEvent());
    }
  }
}
