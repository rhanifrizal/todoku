import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class AppConfigState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;

  const AppConfigState({required this.themeMode, required this.locale});

  factory AppConfigState.initial() {
    return const AppConfigState(
      themeMode: ThemeMode.system,
      locale: Locale('en'),
    );
  }

  AppConfigState copyWith({ThemeMode? themeMode, Locale? locale}) {
    return AppConfigState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [themeMode, locale];
}
