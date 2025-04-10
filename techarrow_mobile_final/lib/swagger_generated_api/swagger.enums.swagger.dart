import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum TaskCategory {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('learning')
  learning('learning'),
  @JsonValue('work')
  work('work'),
  @JsonValue('personal')
  personal('personal');

  final String? value;

  const TaskCategory(this.value);
}

enum Type$ {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('unplanned')
  unplanned('unplanned'),
  @JsonValue('multifaceted')
  multifaceted('multifaceted');

  final String? value;

  const Type$(this.value);
}
