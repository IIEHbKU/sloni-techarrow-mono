import 'package:techarrow_mobile_final/api/api_service.dart';
import 'package:techarrow_mobile_final/enums/task_types.dart';

class TaskCreationFeatures {
  Future<void> createTask(
      {required String title,
      required String description,
      required TaskTypes type,
      required bool isImportant,
      Duration? duration,
      List<Subtask>? subtasks}) async {
    print(
        "$title, $description, $type, $isImportant, $duration, $subtasks - created task");

    await ApiService.postTask(
        title: title,
        description: description,
        type: type,
        isImportant: isImportant,
        duration: duration,
        subtasks: subtasks ?? []);
  }
}

class Subtask {
  String title;
  Duration duration;

  Subtask({required this.title, required this.duration});
}
