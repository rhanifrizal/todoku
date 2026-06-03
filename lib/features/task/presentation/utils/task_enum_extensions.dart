import 'package:flutter/material.dart';
import 'package:todoku/core/enums/task_category_enum.dart';
import 'package:todoku/core/enums/task_priority_enum.dart';
import 'package:todoku/core/extensions/context_extensions.dart';

extension TaskPriorityExtension on TaskPriority {
  String toLocalizedName(BuildContext context) {
    return switch (this) {
      TaskPriority.low => context.l10n.low,
      TaskPriority.medium => context.l10n.medium,
      TaskPriority.high => context.l10n.high,
    };
  }

  Color toColor(BuildContext context) {
    return switch (this) {
      TaskPriority.high => context.colorScheme.error,
      TaskPriority.medium => context.colorScheme.tertiary,
      TaskPriority.low => context.colorScheme.outline,
    };
  }
}

extension TaskCategoryExtension on TaskCategory {
  String toLocalizedName(BuildContext context) {
    return switch (this) {
      TaskCategory.personal => context.l10n.personal,
      TaskCategory.work => context.l10n.work,
      TaskCategory.shopping => context.l10n.shopping,
      TaskCategory.health => context.l10n.health,
      TaskCategory.finance => context.l10n.finance,
    };
  }

  IconData get icon {
    return switch (this) {
      TaskCategory.personal => Icons.person_outline,
      TaskCategory.work => Icons.work_outline,
      TaskCategory.shopping => Icons.shopping_bag_outlined,
      TaskCategory.health => Icons.favorite_border,
      TaskCategory.finance => Icons.account_balance_wallet_outlined,
    };
  }
}
