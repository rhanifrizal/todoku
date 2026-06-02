import 'package:flutter/material.dart';
import 'package:todoku/core/di/injection_container.dart' as di;
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initInjection();
  runApp(const TodoKuApp());
}
