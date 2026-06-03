import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku/core/enums/task_category_enum.dart';
import 'package:todoku/core/enums/task_priority_enum.dart';
import 'package:todoku/core/extensions/context_extensions.dart';
import 'package:todoku/features/task/presentation/bloc/task_bloc.dart';
import 'package:todoku/features/task/presentation/bloc/task_event.dart';
import 'package:todoku/features/task/presentation/utils/task_enum_extensions.dart';

class TaskFilterHeader extends SliverPersistentHeaderDelegate {
  final TextEditingController _searchController = TextEditingController();

  void _dispatchFilter(
    BuildContext context, {
    required String query,
    required TaskPriority? priority,
    required TaskCategory? category,
  }) {
    context.read<TaskBloc>().add(
      FilterTasksEvent(
        searchQuery: query,
        priorityFilter: priority,
        categoryFilter: category,
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final state = context.watch<TaskBloc>().state;
    final currentPriority = state.priorityFilter;
    final currentQuery = state.searchQuery;
    final currentCategory = state.categoryFilter;

    if (_searchController.text != currentQuery) {
      _searchController.value = TextEditingValue(
        text: currentQuery,

        /// This forces the cursor to stay at the very end of the typed text string
        selection: TextSelection.collapsed(offset: currentQuery.length),
      );
    }

    return Material(
      color: context.colorScheme.surface,
      elevation: overlapsContent ? 2 : 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: context.l10n.searchTasks,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: currentQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _dispatchFilter(
                            context,
                            query: '',
                            priority: currentPriority,
                            category: currentCategory,
                          );
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: context.colorScheme.surfaceContainerHighest,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                _dispatchFilter(
                  context,
                  query: value,
                  priority: currentPriority,
                  category: currentCategory,
                );
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      avatar: const Icon(Icons.apps, size: 14),
                      label: Text(context.l10n.all),
                      showCheckmark: false,
                      selected: currentCategory == null,
                      onSelected: (_) {
                        _dispatchFilter(
                          context,
                          query: currentQuery,
                          priority: currentPriority,
                          category: null,
                        );
                      },
                    ),
                  ),
                  ...TaskCategory.values.map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        avatar: Icon(category.icon, size: 14),
                        label: Text(
                          category.toLocalizedName(context).toUpperCase(),
                        ),
                        showCheckmark: false,
                        selected: currentCategory == category,
                        onSelected: (selected) {
                          final nextCategory = selected ? category : null;
                          _dispatchFilter(
                            context,
                            query: currentQuery,
                            priority: currentPriority,
                            category: nextCategory,
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(context.l10n.all),
                      selected: currentPriority == null,
                      onSelected: (_) {
                        _dispatchFilter(
                          context,
                          query: currentQuery,
                          priority: null,
                          category: currentCategory,
                        );
                      },
                    ),
                  ),
                  ...TaskPriority.values.map((priority) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(priority.toLocalizedName(context)),
                        selected: currentPriority == priority,
                        onSelected: (selected) {
                          final nextPriority = selected ? priority : null;
                          _dispatchFilter(
                            context,
                            query: currentQuery,
                            priority: nextPriority,
                            category: currentCategory,
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 164.0;

  @override
  double get minExtent => 164.0;

  @override
  bool shouldRebuild(covariant TaskFilterHeader oldDelegate) => true;
}
