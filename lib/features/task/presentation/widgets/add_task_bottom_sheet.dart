import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';
import 'package:todoku/features/task/presentation/widgets/task_form.dart';

void showAddTaskSheet(BuildContext context) {
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
        child: const AddTaskBottomSheetBody(),
      );
    },
  );
}

class AddTaskBottomSheetBody extends StatelessWidget {
  const AddTaskBottomSheetBody({super.key});

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
              context.l10n.createNewTask,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TaskForm(
              buttonLabel: context.l10n.saveTask,
              onSubmit:
                  (
                    title,
                    description,
                    priority,
                    startDate,
                    dueDate,
                    tags,
                    category,
                  ) {
                    final newTask = TaskEntity(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: title,
                      description: description,
                      isCompleted: false,
                      dateStart: startDate,
                      dueDate: dueDate,
                      tags: tags,
                      priority: priority,
                      category: category,
                      groupId: null,
                    );
                    context.read<TaskBloc>().add(CreateTaskEvent(newTask));
                    context.pop();
                  },
            ),
          ],
        ),
      ),
    );
  }
}
