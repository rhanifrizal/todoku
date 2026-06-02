import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/localization/l10n_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';

void showAddTaskDialog(BuildContext blocContext) {
  showDialog(
    context: blocContext,
    builder: (dialogContext) {
      return _AddTaskDialogContent(blocContext: blocContext);
    },
  );
}

class _AddTaskDialogContent extends StatefulWidget {
  final BuildContext blocContext;

  const _AddTaskDialogContent({required this.blocContext});

  @override
  State<_AddTaskDialogContent> createState() => _AddTaskDialogContentState();
}

class _AddTaskDialogContentState extends State<_AddTaskDialogContent> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.blocContext.l10n.newTask),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: widget.blocContext.l10n.title,
            ),
            autofocus: true,
          ),
          TextField(
            controller: _descController,
            decoration: InputDecoration(
              labelText: widget.blocContext.l10n.description,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(widget.blocContext.l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            final titleText = _titleController.text.trim();
            if (titleText.isEmpty) return;

            final newTask = TaskEntity(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: titleText,
              description: _descController.text.trim(),
              isCompleted: false,
              dateStart: DateTime.now(),
              tags: const [],
              priority: TaskPriority.low,
            );

            widget.blocContext.read<TaskBloc>().add(CreateTaskEvent(newTask));
            Navigator.pop(context);
          },
          child: Text(widget.blocContext.l10n.save),
        ),
      ],
    );
  }
}
