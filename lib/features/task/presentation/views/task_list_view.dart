import 'package:flutter/material.dart';
import 'package:todoku/core/localization/l10n_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
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
      appBar: AppBar(
        title: Text(
          context.l10n.appTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: _buildBody(context),
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

    if (taskList.isEmpty) {
      return Center(child: Text(context.l10n.noTaskFoundCreateOne));
    }

    final todoTasks = taskList.where((task) => !task.isCompleted).toList();
    final completedTasks = taskList.where((task) => task.isCompleted).toList();

    return CustomScrollView(
      slivers: [
        /// TodoTasks Section
        if (todoTasks.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: _sectionHeader(context, title: context.l10n.todoList),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => TaskTile(task: todoTasks[index]),
                childCount: todoTasks.length,
              ),
            ),
          ),
        ],

        /// Spacer between sections if both contain data
        if (todoTasks.isNotEmpty && completedTasks.isNotEmpty)
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

        /// CompletedTasks Section
        if (completedTasks.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: _sectionHeader(context, title: context.l10n.completedTasks),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => TaskTile(task: completedTasks[index]),
                childCount: completedTasks.length,
              ),
            ),
          ),
        ],

        /// Safety bottom padding so the floating action button doesn't block lists
        const SliverToBoxAdapter(child: SizedBox(height: 84)),
      ],
    );
  }

  Widget _sectionHeader(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
