import 'package:flutter/material.dart';
import 'app_keys.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: appNavigatorKey,
      debugShowCheckedModeBanner: false,
      title: "ToDoKu",
      home: const Scaffold(
        body: Center(
          child: Text('App Initialized'),
        ),
      ),
    );
  }
}