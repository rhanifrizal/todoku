import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/domain/entities/task_group_entity.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/widgets/empty_state_widget.dart';
import 'package:todoku/features/task/presentation/widgets/task_filter_header.dart';
import 'package:todoku/features/task/presentation/widgets/task_section_header.dart';
import 'package:todoku/features/task/presentation/widgets/task_tile.dart';

class TaskListView extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<TaskGroupEntity> groups;
  final List<TaskEntity> todoTasks;
  final List<TaskEntity> completedTasks;
  final VoidCallback onAddTaskPressed;
  final VoidCallback onAddGroupPressed;
  final Function(TaskGroupEntity) onGroupPressed;

  const TaskListView({
    required this.isLoading,
    required this.groups,
    required this.todoTasks,
    required this.completedTasks,
    required this.onAddTaskPressed,
    required this.onAddGroupPressed,
    required this.onGroupPressed,
    this.errorMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showActionMenu(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Text(
          'Error: $errorMessage',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        /// Sliver App Bar
        SliverAppBar(
          title: Text(
            context.l10n.appTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 2,
          floating: true,
          surfaceTintColor: Colors.transparent,
          backgroundColor: context.colorScheme.surface,
        ),

        /// Floating Sticky Filter
        SliverPersistentHeader(pinned: true, delegate: TaskFilterHeader()),

        if (groups.isEmpty && todoTasks.isEmpty && completedTasks.isEmpty) ...[
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: EmptyStateWidget(isTaskCompleted: false)),
          ),
        ] else ...[
          /// Horizontal Groups Strip
          if (groups.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: TaskSectionHeader(title: context.l10n.projectGroups),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];

                    final taskState = context.watch<TaskBloc>().state;

                    return Card(
                      margin: const EdgeInsets.only(right: 12, bottom: 8),
                      elevation: 1,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => onGroupPressed(group),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                group.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                taskState.getGroupProgressLabel(
                                  context,
                                  group.id,
                                ),
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],

          /// Active To do Task
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
            const SliverToBoxAdapter(
              child: EmptyStateWidget(isTaskCompleted: false),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          /// Completed Tasks
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
            const SliverToBoxAdapter(
              child: EmptyStateWidget(isTaskCompleted: true),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 84)),
        ],
      ],
    );
  }

  void _showActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: Text(context.l10n.createNewTask),
              onTap: () {
                context.pop(sheetContext);
                onAddTaskPressed();
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_open),
              title: Text(context.l10n.createNewProjectGroup),
              onTap: () {
                context.pop(sheetContext);
                onAddGroupPressed();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
