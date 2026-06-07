import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_state.dart';
import 'package:todoku/features/task/presentation/views/task_group_detail_view.dart';

class TaskGroupDetailScreen extends StatelessWidget {
  final String groupId;

  const TaskGroupDetailScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final currentGroup = state.groupList.firstWhereOrNull(
          (g) => g.id == groupId,
        );

        if (currentGroup == null || currentGroup.id.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final groupTasks = state.taskList
            .where((task) => task.groupId == currentGroup.id)
            .toList();

        final todoTasks = groupTasks
            .where((task) => !task.isCompleted)
            .toList();
        final completedTasks = groupTasks
            .where((task) => task.isCompleted)
            .toList();

        return TaskGroupDetailView(
          group: currentGroup,
          todoTasks: todoTasks,
          completedTasks: completedTasks,
          progressLabel: state.getGroupProgressLabel(context, currentGroup.id),
        );
      },
    );
  }
}
