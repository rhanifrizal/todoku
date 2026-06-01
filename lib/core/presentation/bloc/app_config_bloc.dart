import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_config_event.dart';
import 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  AppConfigBloc() : super(AppConfigState.initial()) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<AppConfigState> emit) {
    final nextTheme = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    emit(state.copyWith(themeMode: nextTheme));
  }

  void _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<AppConfigState> emit,
  ) {
    emit(state.copyWith(locale: event.locale));
  }
}
