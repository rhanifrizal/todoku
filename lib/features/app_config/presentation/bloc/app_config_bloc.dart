import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/usecases/usecase.dart';
import 'package:todoku/features/app_config/domain/usecases/get_app_config_usecase.dart';
import 'package:todoku/features/app_config/domain/usecases/save_app_config_usecase.dart';
import 'app_config_event.dart';
import 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  final GetAppConfigUsecase _getAppConfigUsecase;
  final SaveAppConfigUsecase _saveAppConfigUsecase;

  AppConfigBloc({
    required GetAppConfigUsecase getAppConfigUsecase,
    required SaveAppConfigUsecase saveAppConfigUsecase,
  }) : _getAppConfigUsecase = getAppConfigUsecase,
       _saveAppConfigUsecase = saveAppConfigUsecase,
       super(AppConfigState.initial()) {
    on<InitConfigEvent>(_onInitConfig);
    on<ToggleThemeEvent>(_onToggleTheme);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onInitConfig(
    InitConfigEvent event,
    Emitter<AppConfigState> emit,
  ) async {
    final (failure, payload) = await _getAppConfigUsecase(NoParams());

    if (failure != null || payload == null) {
      emit(AppConfigState.initial());
      return;
    }

    final theme = switch (payload.themeMode) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };

    final locale = payload.languageCode == "ms"
        ? const Locale("ms")
        : const Locale("en");

    emit(AppConfigState(themeMode: theme, locale: locale));
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<AppConfigState> emit,
  ) async {
    final nextTheme = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    emit(state.copyWith(themeMode: nextTheme));
    await _saveAppConfigUsecase(
      SaveConfigParams(type: ConfigType.theme, value: nextTheme.name),
    );
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<AppConfigState> emit,
  ) async {
    emit(state.copyWith(locale: event.locale));
    await _saveAppConfigUsecase(
      SaveConfigParams(
        type: ConfigType.language,
        value: event.locale.languageCode,
      ),
    );
  }
}
