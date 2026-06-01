import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

sealed class AppConfigEvent extends Equatable {
  const AppConfigEvent();

  @override
  List<Object?> get props => [];
}

final class ToggleThemeEvent extends AppConfigEvent {
  const ToggleThemeEvent();
}

final class ChangeLanguageEvent extends AppConfigEvent {
  final Locale locale;

  const ChangeLanguageEvent(this.locale);

  @override
  List<Object?> get props => [locale];
}
