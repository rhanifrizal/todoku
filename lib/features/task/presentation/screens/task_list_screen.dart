import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/di/injection_container.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';
import 'package:todoku/features/task/presentation/views/task_list_view.dart';
import 'package:todoku/features/task/presentation/widgets/add_task_dialog.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (context) => sl<TaskBloc>()..add(const LoadTasksEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'TodoKu Tasks',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: const TaskListView(),
        floatingActionButton: Builder(
          builder: (blocContext) => FloatingActionButton(
            onPressed: () => showAddTaskDialog(blocContext),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
