import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoku/core/localization/l10n_extension.dart';
import 'package:todoku/features/app_config/presentation/screens/settings_screen.dart';
import 'package:todoku/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:todoku/features/task/presentation/screens/task_list_screen.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "rootNav");

  static const String root = "/";
  static const String taskList = "/taskList";
  static const String settings = "/settings";

  static final GoRouter router = GoRouter(
    navigatorKey: _navigatorKey,
    initialLocation: root,
    debugLogDiagnostics: false,
    routes: <RouteBase>[
      GoRoute(path: root, redirect: (context, state) => taskList),
      ShellRoute(
        builder: (context, state, child) {
          return DashboardScreen(child: child);
        },
        routes: [
          GoRoute(
            path: taskList,
            name: taskList,
            builder: (BuildContext context, GoRouterState state) {
              return const TaskListScreen();
            },
          ),
          GoRoute(
            path: settings,
            name: settings,
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsScreen();
            },
          ),
        ],
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
