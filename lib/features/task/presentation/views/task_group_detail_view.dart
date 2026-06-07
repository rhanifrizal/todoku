import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/core/extensions/date_time_extensions.dart';
import 'package:todoku/core/widgets/app_confirmation_dialog.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/domain/entities/task_group_entity.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';
import 'package:todoku/features/task/presentation/widgets/add_task_bottom_sheet.dart';
import 'package:todoku/features/task/presentation/widgets/edit_group_bottom_sheet.dart';
import 'package:todoku/features/task/presentation/widgets/empty_state_widget.dart';
import 'package:todoku/features/task/presentation/widgets/task_section_header.dart';
import 'package:todoku/features/task/presentation/widgets/task_tile.dart';

enum GroupAction { edit, delete }

class TaskGroupDetailView extends StatelessWidget {
  final TaskGroupEntity group;
  final List<TaskEntity> todoTasks;
  final List<TaskEntity> completedTasks;
  final String progressLabel;

  const TaskGroupDetailView({
    super.key,
    required this.group,
    required this.todoTasks,
    required this.completedTasks,
    required this.progressLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.colorScheme.surface,
        title: Text(group.name, style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [_popupMenu(context)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskBottomSheet(context, groupId: group.id),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (todoTasks.isEmpty && completedTasks.isEmpty) {
      return const Center(child: EmptyStateWidget(isTaskCompleted: false));
    }

    return CustomScrollView(
      slivers: [
        /// Progress States Banner
        SliverToBoxAdapter(child: _taskProgress(context)),

        /// Active Tasks Section
        SliverToBoxAdapter(
          child: TaskSectionHeader(title: context.l10n.todoList),
        ),

        if (todoTasks.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => TaskTile(task: todoTasks[index]),
                childCount: todoTasks.length,
              ),
            ),
          )
        else
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: Text(context.l10n.noActiveTasksInThisGroup)),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        /// Completed Tasks Section
        SliverToBoxAdapter(
          child: TaskSectionHeader(title: context.l10n.completedTasks),
        ),

        if (completedTasks.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => TaskTile(task: completedTasks[index]),
                childCount: completedTasks.length,
              ),
            ),
          )
        else
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: Text(context.l10n.noCompletedTasksYet)),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }

  PopupMenuButton<GroupAction> _popupMenu(BuildContext context) {
    return PopupMenuButton<GroupAction>(
      icon: Icon(Icons.more_vert),
      onSelected: (action) {
        switch (action) {
          case GroupAction.edit:
            showEditGroupBottomSheet(context, group: group);
          case GroupAction.delete:
            _confirmDelete(context, group.id);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: GroupAction.edit,
          child: Text(context.l10n.editGroup),
        ),
        PopupMenuItem(
          value: GroupAction.delete,
          child: Text(
            context.l10n.deleteGroup,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _taskProgress(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withAlpha(40),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colorScheme.primaryContainer,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.groupProgress,
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            progressLabel,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (group.dueDate != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: context.colorScheme.outline,
                ),
                const SizedBox(width: 6),
                Text(
                  context.l10n.targetDeadline(
                    group.dueDate!.toDisplayFormat(context),
                  ),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, String currentGroupId) {
    showAppConfirmationDialog(
      context,
      icon: const Icon(Icons.delete_forever_outlined, size: 40),
      title: context.l10n.deleteGroupQuestionMark,
      description:
          context.l10n.allTasksInThisGroupWillAlsoBeDeletedThisCannotBeUndone,
      confirmLabel: context.l10n.delete,
      isDestructive: true,
      onConfirm: (dialogContext) {
        context.read<TaskBloc>().add(DeleteGroupEvent(currentGroupId));
        dialogContext.pop();
        context.pop();
      },
    );
  }
}
