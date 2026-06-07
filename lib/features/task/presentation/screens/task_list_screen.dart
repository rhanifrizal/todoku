import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoku/app/routes/app_routes.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_state.dart';
import 'package:todoku/features/task/presentation/views/task_list_view.dart';
import 'package:todoku/features/task/presentation/widgets/add_task_bottom_sheet.dart';
import 'package:todoku/features/task/presentation/widgets/add_group_bottom_sheet.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listenWhen: (previous, current) =>
          current.isFailure && current.taskList.isNotEmpty,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: context.colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (blocContext, state) {
          final standaloneTasks = state.standaloneTaskList;

          final todoTasks = standaloneTasks
              .where((task) => !task.isCompleted)
              .toList();
          final completedTasks = standaloneTasks
              .where((task) => task.isCompleted)
              .toList();

          return TaskListView(
            isLoading:
                state.isLoading &&
                state.taskList.isEmpty &&
                state.groupList.isEmpty,
            errorMessage: (state.taskList.isEmpty && state.groupList.isEmpty)
                ? state.errorMessage
                : null,
            groups: state.groupList,
            todoTasks: todoTasks,
            completedTasks: completedTasks,
            onAddTaskPressed: () => showAddTaskBottomSheet(blocContext),
            onAddGroupPressed: () => showAddGroupBottomSheet(blocContext),
            onGroupPressed: (group) {
              context.pushNamed(
                AppRoutes.taskGroupDetail,
                pathParameters: {'groupId': group.id},
              );
            },
          );
        },
      ),
    );
  }
}
