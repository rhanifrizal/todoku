import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/localization/l10n_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';

void showAddTaskDialog(BuildContext blocContext) {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  showDialog(
    context: blocContext,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(blocContext.l10n.newTask),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: blocContext.l10n.title),
              autofocus: true,
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                labelText: blocContext.l10n.description,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(blocContext.l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final titleText = titleController.text.trim();
              if (titleText.isEmpty) return;

              final newTask = TaskEntity(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: titleText,
                description: descController.text.trim(),
                isCompleted: false,
                dateStart: DateTime.now(),
                tags: const [],
                priority: TaskPriority.low,
              );

              blocContext.read<TaskBloc>().add(CreateTaskEvent(newTask));
              Navigator.pop(dialogContext);
            },
            child: Text(blocContext.l10n.save),
          ),
        ],
      );
    },
  );
}
