import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';
import 'package:todoku/features/task/presentation/widgets/task_form.dart';

void showEditTaskSheet(BuildContext context, {required TaskEntity task}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (bottomSheetContext) {
      return BlocProvider.value(
        value: BlocProvider.of<TaskBloc>(context),
        child: EditTaskBottomSheetBody(task: task),
      );
    },
  );
}

class EditTaskBottomSheetBody extends StatelessWidget {
  final TaskEntity task;

  const EditTaskBottomSheetBody({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: context.bottomInsets + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.editTask,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TaskForm(
              initialTask: task,
              buttonLabel: context.l10n.updateTask,
              onSubmit:
                  (title, description, priority, startDate, dueDate, tags) {
                    final updatedTask = task.copyWith(
                      title: title,
                      description: description,
                      priority: priority,
                      dateStart: startDate,
                      dueDate: () => dueDate,
                      tags: tags,
                    );
                    context.read<TaskBloc>().add(UpdateTaskEvent(updatedTask));
                    context.pop();
                  },
            ),
          ],
        ),
      ),
    );
  }
}
