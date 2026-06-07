import 'package:equatable/equatable.dart';

class TaskGroupEntity extends Equatable {
  final String id;
  final String name;
  final DateTime? dueDate;
  final bool isCompleted;

  const TaskGroupEntity({
    required this.id,
    required this.name,
    this.dueDate,
    this.isCompleted = false,
  });

  TaskGroupEntity copyWith({
    String? name,
    DateTime? Function()? dueDate,
    bool? isCompleted,
  }) {
    return TaskGroupEntity(
      id: id,
      name: name ?? this.name,
      dueDate: dueDate != null ? dueDate() : this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, name, dueDate, isCompleted];
}
