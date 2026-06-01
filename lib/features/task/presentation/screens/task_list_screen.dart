import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/di/injection_container.dart';
import 'package:todoku/core/localization/l10n_extensions.dart';
import 'package:todoku/core/presentation/bloc/app_config_bloc.dart';
import 'package:todoku/core/presentation/bloc/app_config_event.dart';
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
          title: Text(
            context.l10n.appTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 2,
          actions: [
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                final currentLocale = context
                    .read<AppConfigBloc>()
                    .state
                    .locale
                    .languageCode;
                final nextLocale = currentLocale == 'en'
                    ? const Locale('ms')
                    : const Locale('en');
                context.read<AppConfigBloc>().add(
                  ChangeLanguageEvent(nextLocale),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () {
                context.read<AppConfigBloc>().add(const ToggleThemeEvent());
              },
            ),
          ],
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
