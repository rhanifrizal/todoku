import 'package:flutter/material.dart';
import 'package:todoku/app/theme/theme_extension.dart';
import 'package:todoku/core/localization/l10n_extension.dart';

class EmptyStateWidget extends StatelessWidget {
  final bool isCompletedTasksSection;

  const EmptyStateWidget({super.key, this.isCompletedTasksSection = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 20 * (1.0 - value)),
            child: Opacity(opacity: value, child: child),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isCompletedTasksSection
                      ? context.colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.3,
                        )
                      : context.colorScheme.primaryContainer.withValues(
                          alpha: 0.2,
                        ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCompletedTasksSection
                      ? Icons.assignment_turned_in_outlined
                      : Icons.assignment_outlined,
                  size: 64,
                  color: isCompletedTasksSection
                      ? context.colorScheme.outline
                      : context.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                isCompletedTasksSection
                    ? context.l10n.noCompletedTasksYet
                    : context.l10n.allDoneForNow,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isCompletedTasksSection
                    ? context.l10n.completeYourTaskRightNow
                    : context.l10n.createANewTaskRightNow,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
