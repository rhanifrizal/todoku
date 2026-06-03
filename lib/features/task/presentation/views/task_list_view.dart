import 'package:flutter/material.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/presentation/widgets/empty_state_widget.dart';
import 'package:todoku/features/task/presentation/widgets/task_filter_header.dart';
import 'package:todoku/features/task/presentation/widgets/task_tile.dart';

class TaskListView extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<TaskEntity> taskList;
  final VoidCallback onAddTaskPressed;

  const TaskListView({
    required this.isLoading,
    required this.taskList,
    required this.onAddTaskPressed,
    this.errorMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddTaskPressed,
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

    final todoTasks = taskList.where((task) => !task.isCompleted).toList();
    final completedTasks = taskList.where((task) => task.isCompleted).toList();

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

        /// Global empty state fallback (If completely empty)
        if (taskList.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: EmptyStateWidget(isCompletedTasksSection: false),
            ),
          )
        else ...[
          /// TodoTasks Section
          SliverToBoxAdapter(
            child: _sectionHeader(context, title: context.l10n.todoList),
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
            /// Shows when user has completed tasks, but no active to do tasks remaining
            const SliverToBoxAdapter(
              child: EmptyStateWidget(isCompletedTasksSection: false),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          /// CompletedTasks Section
          SliverToBoxAdapter(
            child: _sectionHeader(context, title: context.l10n.completedTasks),
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
            /// Shows when user has active tasks, but hasn't completed anything yet
            const SliverToBoxAdapter(
              child: EmptyStateWidget(isCompletedTasksSection: true),
            ),

          /// Safety bottom padding so the floating action button doesn't block lists
          const SliverToBoxAdapter(child: SizedBox(height: 84)),
        ],
      ],
    );
  }

  Widget _sectionHeader(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Text(
        title,
        style: context.textTheme.titleSmall?.copyWith(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
