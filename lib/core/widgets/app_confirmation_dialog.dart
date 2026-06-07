import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoku/core/extensions/context_extensions.dart';

void showAppConfirmationDialog(
  BuildContext context, {
  required String title,
  required String description,
  required void Function(BuildContext dialogContext) onConfirm,
  String? confirmLabel,
  String? cancelLabel,
  bool isDestructive = false,
  Widget? icon,
}) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AppConfirmationDialogBody(
        title: title,
        description: description,
        onConfirm: onConfirm,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
        icon: icon,
      );
    },
  );
}

class AppConfirmationDialogBody extends StatelessWidget {
  final String title;
  final String description;
  final String? confirmLabel;
  final String? cancelLabel;
  final void Function(BuildContext dialogContext) onConfirm;
  final bool isDestructive;
  final Widget? icon;

  const AppConfirmationDialogBody({
    super.key,
    required this.title,
    required this.description,
    required this.onConfirm,
    this.confirmLabel,
    this.cancelLabel,
    this.isDestructive = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      iconColor: context.colorScheme.primary,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: icon != null ? TextAlign.center : TextAlign.start,
      ),
      content: Text(
        description,
        textAlign: icon != null ? TextAlign.center : TextAlign.start,
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(cancelLabel ?? context.l10n.cancel),
        ),
        TextButton(
          onPressed: () => onConfirm(context),
          child: Text(
            confirmLabel ?? context.l10n.confirm,
            style: TextStyle(
              color: isDestructive ? Colors.red : context.colorScheme.primary,
              fontWeight: isDestructive ? FontWeight.bold : null,
            ),
          ),
        ),
      ],
    );
  }
}
