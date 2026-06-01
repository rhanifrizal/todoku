import 'package:flutter/material.dart';
import 'package:todoku/core/di/injection_container.dart' as di;
import 'package:todoku/core/presentation/widgets/security_overlay_switcher.dart';
import 'package:todoku/features/task/presentation/screens/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initInjection();
  runApp(const TodoKuApp());
}

class TodoKuApp extends StatelessWidget {
  const TodoKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      builder: (context, child) {
        return SecurityOverlaySwitcher(child: child ?? const SizedBox.shrink());
      },
      home: const TaskListScreen(),
    );
  }
}
