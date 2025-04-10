class Task {
  int id = 0;
  String title = '';
  String description = '';
  int startTime = 0;
  int endTime = 0;
  int colorId = 0; // 0 - red, 1 - blue, 2 - green
  late int len;
  TaskStatus status = TaskStatus.unscheduled;

  Task(
    this.id,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.colorId, {
    this.status = TaskStatus.unscheduled,
  }) {
    this.len = endTime - startTime;
  }
}

enum TaskStatus { unscheduled, scheduled, done }
