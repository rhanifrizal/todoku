import 'package:flutter/material.dart';
import 'package:todoku/core/localization/l10n_extension.dart';

class DashboardView extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabTapped;
  final Widget child;

  const DashboardView({
    required this.currentIndex,
    required this.onTabTapped,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.check_circle_outline),
            activeIcon: const Icon(Icons.check_circle),
            label: context.l10n.appTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: context.l10n.settings,
          ),
        ],
      ),
    );
  }
}
