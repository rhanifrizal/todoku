enum TaskPriority {
  low,
  medium,
  high;

  bool get isHigh => this == TaskPriority.high;
}
