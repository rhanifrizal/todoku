import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/di/injection_container.dart' as di;
import 'package:todoku/core/localization/l10n/app_localizations.dart';
import 'package:todoku/core/presentation/bloc/app_config_bloc.dart';
import 'package:todoku/core/presentation/bloc/app_config_state.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppConfigBloc>(
          create: (context) => di.sl<AppConfigBloc>(),
        ),
      ],
      child: BlocBuilder<AppConfigBloc, AppConfigState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'TodoKu',
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
            ),
            locale: state.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) {
              return SecurityOverlaySwitcher(
                child: child ?? const SizedBox.shrink(),
              );
            },
            home: const TaskListScreen(),
          );
        },
      ),
    );
  }
}
