import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/app/routes/app_routes.dart';
import 'package:todoku/app/theme/app_theme.dart';
import 'package:todoku/core/di/injection_container.dart' as di;
import 'package:todoku/core/localization/l10n/app_localizations.dart';
import 'package:todoku/features/app_config/presentation/bloc/app_config_bloc.dart';
import 'package:todoku/features/app_config/presentation/bloc/app_config_event.dart';
import 'package:todoku/features/app_config/presentation/bloc/app_config_state.dart';
import 'package:todoku/features/app_config/presentation/widgets/security_overlay_switcher.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';

class TodoKuApp extends StatelessWidget {
  const TodoKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppConfigBloc>(
          create: (context) =>
              di.sl<AppConfigBloc>()..add(const InitConfigEvent()),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => di.sl<TaskBloc>()
            ..add(const LoadTasksEvent())
            ..add(const LoadGroupEvent()),
        ),
      ],
      child: BlocBuilder<AppConfigBloc, AppConfigState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: "TodoKu",
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            locale: state.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: AppRoutes.router,
            builder: (context, child) {
              return SecurityOverlaySwitcher(
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
