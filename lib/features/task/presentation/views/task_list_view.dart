import 'package:flutter/material.dart';
import 'package:todoku/core/localization/l10n_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/presentation/widgets/task_tile.dart';

class TaskListView extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<TaskEntity> tasksList;
  final VoidCallback onAddTaskPressed;

  const TaskListView({
    required this.isLoading,
    required this.tasksList,
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

    if (tasksList.isEmpty) {
      return Center(child: Text(context.l10n.noTaskFoundCreateOne));
    }

    return ListView.builder(
      itemCount: tasksList.length,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemBuilder: (context, index) => TaskTile(task: tasksList[index]),
    );
  }
}
