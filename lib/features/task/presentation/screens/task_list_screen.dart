import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/di/injection_container.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';
import 'package:todoku/features/task/presentation/bloc/task_state.dart';
import 'package:todoku/features/task/presentation/views/task_list_view.dart';
import 'package:todoku/features/task/presentation/widgets/add_task_bottom_sheet.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (context) => sl<TaskBloc>()..add(const LoadTasksEvent()),
      child: BlocListener<TaskBloc, TaskState>(
        listenWhen: (previous, current) =>
            current.isFailure && current.taskList.isNotEmpty,
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (blocContext, state) {
            return TaskListView(
              isLoading: state.isLoading && state.taskList.isEmpty,
              errorMessage: state.taskList.isEmpty ? state.errorMessage : null,
              taskList: state.taskList,
              onAddTaskPressed: () => showAddTaskSheet(blocContext),
            );
          },
        ),
      ),
    );
  }
}
