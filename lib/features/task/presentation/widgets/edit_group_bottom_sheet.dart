import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_group_entity.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';

import 'group_form.dart';

void showEditGroupBottomSheet(
  BuildContext context, {
  required TaskGroupEntity group,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (bottomSheetContext) {
      return BlocProvider.value(
        value: BlocProvider.of<TaskBloc>(context),
        child: EditGroupBottomSheetBody(group: group),
      );
    },
  );
}

class EditGroupBottomSheetBody extends StatelessWidget {
  final TaskGroupEntity group;

  const EditGroupBottomSheetBody({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: context.bottomInsets + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.editGroupDetails,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GroupForm(
              initialGroup: group,
              buttonLabel: context.l10n.saveChanges,
              onSubmit: (name, dueDate) {
                final updatedGroup = group.copyWith(
                  name: name,
                  dueDate: () => dueDate,
                );

                context.read<TaskBloc>().add(UpdateGroupEvent(updatedGroup));
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
