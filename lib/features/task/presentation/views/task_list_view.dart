import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/localization/l10n_extensions.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_state.dart';
import 'package:todoku/features/task/presentation/widgets/task_tile.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return switch (state) {
          TaskInitialState() || TaskLoadingState() => const Center(
            child: CircularProgressIndicator(),
          ),
          TaskFailureState(errorMessage: final message) => Center(
            child: Text(
              'Error: $message',
              style: const TextStyle(color: Colors.red),
            ),
          ),
          TaskSuccessState(tasks: final taskList) =>
            taskList.isEmpty
                ? Center(child: Text(context.l10n.noTaskFoundCreateOne))
                : ListView.builder(
                    itemCount: taskList.length,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    itemBuilder: (context, index) =>
                        TaskTile(task: taskList[index]),
                  ),
        };
      },
    );
  }
}
