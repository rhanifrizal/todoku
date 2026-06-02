import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// Formats the date to 'd MMMM yyyy' using the current device locale.
  /// Example: 2 June 2026 or 2 Jun 2026 (based on language settings).
  String toDisplayFormat(BuildContext context) {
    final String locale = Localizations.localeOf(context).languageCode;
    return DateFormat('d MMMM yyyy', locale).format(toLocal());
  }
}