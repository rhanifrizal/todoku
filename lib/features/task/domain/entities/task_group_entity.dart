class TaskGroupEntity {
  final String id;
  final String name;
  final DateTime? dueDate;
  final bool isCompleted;

  const TaskGroupEntity({
    required this.id,
    required this.name,
    this.dueDate,
    required this.isCompleted,
  });
}
