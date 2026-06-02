import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/di/injection_container.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';
import 'package:todoku/features/task/presentation/bloc/task_state.dart';
import 'package:todoku/features/task/presentation/views/task_list_view.dart';
import 'package:todoku/features/task/presentation/widgets/add_task_dialog.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (context) => sl<TaskBloc>()..add(const LoadTasksEvent()),
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (blocContext, state) {
          return TaskListView(
            isLoading: state is TaskInitialState || state is TaskLoadingState,
            errorMessage: state is TaskFailureState ? state.errorMessage : null,
            tasksList: state is TaskSuccessState ? state.tasksList : const [],
            onAddTaskPressed: () => showAddTaskDialog(blocContext),
          );
        },
      ),
    );
  }
}
