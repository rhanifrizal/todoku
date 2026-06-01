import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';

class TaskTile extends StatelessWidget {
  final TaskEntity task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: task.description.isNotEmpty ? Text(task.description) : null,
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (bool? newValue) {
            final updatedTask = task.copyWith(isCompleted: newValue ?? false);
            context.read<TaskBloc>().add(UpdateTaskEvent(updatedTask));
          },
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () {
            context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
          },
        ),
      ),
    );
  }
}
