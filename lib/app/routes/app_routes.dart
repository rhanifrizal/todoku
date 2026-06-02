import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoku/core/localization/l10n_extensions.dart';
import 'package:todoku/features/task/presentation/screens/task_list_screen.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "rootNav");

  static const String root = "/";
  static const String taskList = "/taskList";

  static final GoRouter router = GoRouter(
    navigatorKey: _navigatorKey,
    initialLocation: root,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(path: root, redirect: (context, state) => taskList),
      GoRoute(
        path: taskList,
        name: taskList,
        builder: (BuildContext context, GoRouterState state) {
          return const TaskListScreen();
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          context.l10n.routePathNotFound(state.uri.path),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}

// Example path placeholders for future modules:
// static const String taskDetails = '/tasks/:id';
// static const String settings = '/settings';
