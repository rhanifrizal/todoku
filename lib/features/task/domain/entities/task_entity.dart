enum TaskPriority {
  low,
  medium,
  high;

  bool get isHigh => this == TaskPriority.high;
}

class TaskEntity {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime dateStart;
  final DateTime? dueDate;
  final List<String> tags;
  final String? category;
  final TaskPriority priority;
  final String? groupId;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.dateStart,
    this.dueDate,
    required this.tags,
    this.category,
    required this.priority,
    this.groupId,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dateStart,
    DateTime? Function()? dueDate,
    List<String>? tags,
    String? Function()? category,
    TaskPriority? priority,
    String? Function()? groupId,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dateStart: dateStart ?? this.dateStart,
      dueDate: dueDate != null ? dueDate() : this.dueDate,
      tags: tags ?? this.tags,
      category: category != null ? category() : this.category,
      priority: priority ?? this.priority,
      groupId: groupId != null ? groupId() : this.groupId,
    );
  }
}
