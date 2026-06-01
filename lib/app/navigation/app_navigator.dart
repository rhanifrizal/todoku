import 'package:flutter/material.dart';

abstract final class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void logoutAndRedirect() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/login',
      (Route<dynamic> route) => false,
    );
  }
}
