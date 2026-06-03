import 'package:flutter/material.dart';
import 'package:todoku/core/enums/task_category_enum.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/features/task/presentation/utils/task_enum_extensions.dart';

class CategorySelector extends StatelessWidget {
  final TaskCategory? selectedCategory;
  final ValueChanged<TaskCategory?> onCategorySelected;

  const CategorySelector({
    required this.selectedCategory,
    required this.onCategorySelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.category,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  avatar: const Icon(Icons.clear, size: 16),
                  label: Text(context.l10n.none),
                  selected: selectedCategory == null,
                  onSelected: (_) => onCategorySelected(null),
                ),
              ),
              ...TaskCategory.values.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    avatar: Icon(category.icon, size: 16),
                    label: Text(category.toLocalizedName(context)),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      onCategorySelected(selected ? category : null);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
