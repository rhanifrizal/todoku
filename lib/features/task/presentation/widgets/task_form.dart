import 'package:flutter/material.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/core/extensions/date_time_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_entity.dart';

class TaskForm extends StatefulWidget {
  final TaskEntity? initialTask;
  final String buttonLabel;
  final void Function(
    String title,
    String description,
    TaskPriority priority,
    DateTime startDate,
    DateTime? dueDate,
    List<String> tags,
  )
  onSubmit;

  const TaskForm({
    super.key,
    this.initialTask,
    required this.buttonLabel,
    required this.onSubmit,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _tagsController;

  late TaskPriority _selectedPriority;
  late DateTime _startDate;
  DateTime? _dueDate;

  static const int _maxTagsPerTask = 5;
  static const int _maxTagLength = 15;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.initialTask?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialTask?.description ?? '',
    );
    _tagsController = TextEditingController(
      text: widget.initialTask?.tags.join(', ') ?? '',
    );
    _selectedPriority = widget.initialTask?.priority ?? TaskPriority.medium;
    _startDate = widget.initialTask?.dateStart ?? DateTime.now();
    _dueDate = widget.initialTask?.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  List<String> _parseAndSanitizeTags(String input) {
    if (input.trim().isEmpty) return const [];
    final cleanInput = input.replaceAll(RegExp(r'[^\w\s,\-]'), '');
    return cleanInput
        .split(',')
        .map((tag) => tag.trim().toLowerCase())
        .where((tag) => tag.isNotEmpty)
        .take(_maxTagsPerTask)
        .toList();
  }

  Future<void> _pickDate({required bool isStartDate}) async {
    FocusScope.of(context).unfocus();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : (_dueDate ?? _startDate),
      firstDate: isStartDate
          ? DateTime.now().subtract(const Duration(days: 365))
          : _startDate,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
          if (_dueDate != null && _dueDate!.isBefore(_startDate)) {
            _dueDate = _startDate;
          }
        } else {
          _dueDate = pickedDate;
        }
      });
    }
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSubmit(
      _titleController.text.trim(),
      _descriptionController.text.trim(),
      _selectedPriority,
      _startDate,
      _dueDate,
      _parseAndSanitizeTags(_tagsController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double elementSpacing = 16.0;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _titleController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: context.l10n.taskTitle,
              border: const OutlineInputBorder(),
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
              border: const OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: elementSpacing),
          TextFormField(
            controller: _tagsController,
            textCapitalization: TextCapitalization.none,
            decoration: InputDecoration(
              labelText: context.l10n.tagsLabel,
              hintText: context.l10n.tagsHint,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.local_offer_outlined),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return null;
              final rawTags = value
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty);
              if (rawTags.length > _maxTagsPerTask) {
                return context.l10n.tooManyTagsError;
              }
              for (final tag in rawTags) {
                if (tag.length > _maxTagLength) {
                  return context.l10n.tagTooLongError;
                }
              }
              return null;
            },
          ),
          const SizedBox(height: elementSpacing),
          Text(context.l10n.priority, style: context.textTheme.bodyLarge),
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
                    if (selected) setState(() => _selectedPriority = priority);
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
                    '${context.l10n.starts}: ${_startDate.toDisplayFormat(context)}',
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
                        : '${context.l10n.due}: ${_dueDate?.toDisplayFormat(context)}',
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
              onPressed: _handleSave,
              child: Text(
                widget.buttonLabel,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
