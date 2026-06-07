import 'package:flutter/material.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/core/extensions/date_time_extensions.dart';
import 'package:todoku/features/task/domain/entities/task_group_entity.dart';

class GroupForm extends StatefulWidget {
  final TaskGroupEntity? initialGroup;
  final String buttonLabel;
  final void Function(String name, DateTime? dueDate) onSubmit;

  const GroupForm({
    super.key,
    this.initialGroup,
    required this.buttonLabel,
    required this.onSubmit,
  });

  @override
  State<GroupForm> createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.initialGroup?.name ?? '',
    );
    _dueDate = widget.initialGroup?.dueDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    FocusScope.of(context).unfocus();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSubmit(_nameController.text.trim(), _dueDate);
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
            controller: _nameController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: context.l10n.groupName,
              hintText: context.l10n.groupNameHint,
              border: const OutlineInputBorder(),
            ),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? context.l10n.nameIsRequired
                : null,
          ),
          const SizedBox(height: elementSpacing),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _dueDate == null
                        ? context.l10n.setTargetDueDate
                        : '${context.l10n.due}: ${_dueDate?.toDisplayFormat(context)}',
                  ),
                ),
              ),
              if (_dueDate != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => setState(() => _dueDate = null),
                  icon: const Icon(Icons.clear, color: Colors.red),
                ),
              ],
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
