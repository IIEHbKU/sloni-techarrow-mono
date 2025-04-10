import 'package:techarrow_mobile_final/swagger_generated_api/swagger.swagger.dart';

enum TaskTypes { learning, work, personal }

TaskCategory taskTypeToTaskCategory(TaskTypes type) {
  switch (type) {
    case TaskTypes.learning:
      return TaskCategory.learning;
    case TaskTypes.work:
      return TaskCategory.work;
    case TaskTypes.personal:
      return TaskCategory.personal;
  }
}
