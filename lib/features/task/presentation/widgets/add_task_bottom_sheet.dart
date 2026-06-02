import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoku/core/localization/l10n_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';

void showAddTaskSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (bottomSheetContext) {
      return BlocProvider.value(
        value: BlocProvider.of<TaskBloc>(context),
        child: const AddTaskBottomSheetBody(),
      );
    },
  );
}

class AddTaskBottomSheetBody extends StatefulWidget {
  const AddTaskBottomSheetBody({super.key});

  @override
  State<AddTaskBottomSheetBody> createState() => _AddTaskBottomSheetBodyState();
}

class _AddTaskBottomSheetBodyState extends State<AddTaskBottomSheetBody> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  TaskPriority _selectedPriority = TaskPriority.medium;
  DateTime _startDate = DateTime.now();
  DateTime? _dueDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStartDate}) async {
    final initialDate = isStartDate ? _startDate : (_dueDate ?? DateTime.now());
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
          if (_dueDate != null && _dueDate!.isBefore(_startDate)) {
            _dueDate = null;
          }
        } else {
          _dueDate = pickedDate;
        }
      });
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final newTask = TaskEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      isCompleted: false,
      dateStart: _startDate,
      dueDate: _dueDate,
      tags: const [],
      priority: _selectedPriority,
    );

    context.read<TaskBloc>().add(CreateTaskEvent(newTask));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    const double elementSpacing = 16.0;

    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.createNewTask,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: elementSpacing),
              TextFormField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: context.l10n.taskTitle,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? context.l10n.titleIsRequired
                    : null,
              ),
              const SizedBox(height: elementSpacing),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: context.l10n.description,
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: elementSpacing),
              Text(
                context.l10n.priority,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 6),
              Row(
                children: TaskPriority.values.map((priority) {
                  final String localizedPriorityLabel = switch (priority) {
                    TaskPriority.low => context.l10n.low,
                    TaskPriority.medium => context.l10n.medium,
                    TaskPriority.high => context.l10n.high,
                  };

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(localizedPriorityLabel.toUpperCase()),
                      selected: _selectedPriority == priority,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedPriority = priority);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: elementSpacing),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickDate(isStartDate: true),
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        '${context.l10n.starts}: ${_startDate.toLocal().toString().split(' ')[0]}',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickDate(isStartDate: false),
                      icon: const Icon(Icons.event),
                      label: Text(
                        _dueDate == null
                            ? context.l10n.setDueDate
                            : '${context.l10n.due} ${_dueDate!.toLocal().toString().split(' ')[0]}',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _submitForm,
                  child: Text(
                    context.l10n.saveTask,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
