import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoku/core/localization/l10n_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';

class TaskTile extends StatelessWidget {
  final TaskEntity task;

  const TaskTile({super.key, required this.task});

  String _getLocalizedPriority(BuildContext context, TaskPriority priority) {
    return switch (priority) {
      TaskPriority.low => context.l10n.low,
      TaskPriority.medium => context.l10n.medium,
      TaskPriority.high => context.l10n.high,
    };
  }

  Color _getPriorityColor(BuildContext context, TaskPriority priority) {
    final theme = Theme.of(context);
    return switch (priority) {
      TaskPriority.high => theme.colorScheme.error,
      TaskPriority.medium => theme.colorScheme.tertiary,
      TaskPriority.low => theme.colorScheme.outline,
    };
  }

  String _formatDate(BuildContext context, DateTime date) {
    final String locale = Localizations.localeOf(context).languageCode;
    return DateFormat('d MMMM yyyy', locale).format(date.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priorityColor = _getPriorityColor(context, task.priority);
    final localizedPriority = _getLocalizedPriority(context, task.priority);

    final bool isOverdue =
        task.dueDate != null &&
        task.dueDate!.isBefore(DateTime.now()) &&
        !task.isCompleted;

    return Dismissible(
      key: Key('task_${task.id}'),
      confirmDismiss: (direction) async {
        final taskBloc = context.read<TaskBloc>();

        await HapticFeedback.lightImpact();

        if (!context.mounted) return false;

        if (direction == DismissDirection.startToEnd) {
          final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
          taskBloc.add(UpdateTaskEvent(updatedTask));

          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                updatedTask.isCompleted
                    ? context.l10n.taskMarkedAsCompleted
                    : context.l10n.taskMarkedAsIncomplete,
              ),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: context.l10n.undo.toUpperCase(),
                onPressed: () {
                  taskBloc.add(UpdateTaskEvent(task));
                },
              ),
            ),
          );
          return false;
        }

        if (direction == DismissDirection.endToStart) {
          taskBloc.add(DeleteTaskEvent(task.id));

          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.taskDeleted),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: context.l10n.undo.toUpperCase(),
                onPressed: () {
                  taskBloc.add(CreateTaskEvent(task));
                },
              ),
            ),
          );
          return true;
        }
        return false;
      },
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerLeft,
        child: Icon(
          task.isCompleted ? Icons.undo : Icons.check_circle_outline,
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete_outline,
          color: theme.colorScheme.onErrorContainer,
        ),
      ),
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: ListTile(
            isThreeLine: task.description.isNotEmpty,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: priorityColor, width: 1),
                  ),
                  child: Text(
                    localizedPriority.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: priorityColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (task.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 12,
                          color: theme.colorScheme.outline,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${context.l10n.starts}: ${_formatDate(context, task.dateStart)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                    if (task.dueDate != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.event,
                            size: 12,
                            color: isOverdue
                                ? theme.colorScheme.error
                                : theme.colorScheme.outline,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${context.l10n.due}: ${_formatDate(context, task.dueDate!)}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isOverdue
                                  ? theme.colorScheme.error
                                  : theme.colorScheme.outline,
                              fontWeight: isOverdue ? FontWeight.bold : null,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
