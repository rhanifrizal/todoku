import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/features/app_config/presentation/bloc/app_config_bloc.dart';
import 'package:todoku/features/app_config/presentation/bloc/app_config_event.dart';
import 'package:todoku/features/app_config/presentation/bloc/app_config_state.dart';
import 'package:todoku/features/app_config/presentation/views/settings_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigBloc, AppConfigState>(
      builder: (blocContext, state) {
        return SettingsView(
          themeMode: state.themeMode,
          locale: state.locale,
          onThemeToggle: () {
            blocContext.read<AppConfigBloc>().add(const ToggleThemeEvent());
          },
          onLanguageChanged: (newLocale) {
            blocContext.read<AppConfigBloc>().add(
              ChangeLanguageEvent(newLocale),
            );
          },
        );
      },
    );
  }
}
