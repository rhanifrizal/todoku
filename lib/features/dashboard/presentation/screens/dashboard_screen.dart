import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoku/app/routes/app_routes.dart';
import 'package:todoku/features/dashboard/presentation/views/dashboard_view.dart';

class DashboardScreen extends StatelessWidget {
  final Widget child;

  const DashboardScreen({required this.child, super.key});

  int _calculateActiveIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoutes.settings)) return 1;
    return 0;
  }

  void _onTabNavigationChanged(BuildContext context, int index) {
    if (index == 0) {
      context.go(AppRoutes.taskList);
    } else if (index == 1) {
      context.go(AppRoutes.settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashboardView(
      currentIndex: _calculateActiveIndex(context),
      onTabTapped: (index) => _onTabNavigationChanged(context, index),
      child: child,
    );
  }
}
