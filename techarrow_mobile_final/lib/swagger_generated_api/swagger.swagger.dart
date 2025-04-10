// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'swagger.enums.swagger.dart' as enums;
export 'swagger.enums.swagger.dart';

part 'swagger.swagger.chopper.dart';
part 'swagger.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Swagger extends ChopperService {
  static Swagger create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$Swagger(client);
    }

    final newClient = ChopperClient(
        services: [_$Swagger()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$Swagger(newClient);
  }

  ///Create Advice
  Future<chopper.Response<AdviceCreateRs>> apiAdviceCreatePost(
      {required AdviceCreateRq? body}) {
    generatedMapping.putIfAbsent(
        AdviceCreateRs, () => AdviceCreateRs.fromJsonFactory);

    return _apiAdviceCreatePost(body: body);
  }

  ///Create Advice
  @Post(
    path: '/api/advice/create',
    optionalBody: true,
  )
  Future<chopper.Response<AdviceCreateRs>> _apiAdviceCreatePost(
      {@Body() required AdviceCreateRq? body});

  ///Get Advice
  Future<chopper.Response<AdviceGetRs>> apiAdviceGetGet() {
    generatedMapping.putIfAbsent(
        AdviceGetRs, () => AdviceGetRs.fromJsonFactory);

    return _apiAdviceGetGet();
  }

  ///Get Advice
  @Get(path: '/api/advice/get')
  Future<chopper.Response<AdviceGetRs>> _apiAdviceGetGet();

  ///Update Field
  Future<chopper.Response<FieldAnswer>> apiFieldsUpdatePut(
      {required FieldInput? body}) {
    generatedMapping.putIfAbsent(
        FieldAnswer, () => FieldAnswer.fromJsonFactory);

    return _apiFieldsUpdatePut(body: body);
  }

  ///Update Field
  @Put(
    path: '/api/fields/update',
    optionalBody: true,
  )
  Future<chopper.Response<FieldAnswer>> _apiFieldsUpdatePut(
      {@Body() required FieldInput? body});

  ///Get Field
  ///@param date
  Future<chopper.Response<FieldOutput>> apiFieldsGetDateGet(
      {required String? date}) {
    generatedMapping.putIfAbsent(
        FieldOutput, () => FieldOutput.fromJsonFactory);

    return _apiFieldsGetDateGet(date: date);
  }

  ///Get Field
  ///@param date
  @Get(path: '/api/fields/get/{date}')
  Future<chopper.Response<FieldOutput>> _apiFieldsGetDateGet(
      {@Path('date') required String? date});

  ///Ping
  Future<chopper.Response<HealthcheckPingRs>> apiPingGet() {
    generatedMapping.putIfAbsent(
        HealthcheckPingRs, () => HealthcheckPingRs.fromJsonFactory);

    return _apiPingGet();
  }

  ///Ping
  @Get(path: '/api/ping')
  Future<chopper.Response<HealthcheckPingRs>> _apiPingGet();

  ///Create Task
  Future<chopper.Response<TaskCreateRs>> apiTasksCreatePost(
      {required TaskCreateRq? body}) {
    generatedMapping.putIfAbsent(
        TaskCreateRs, () => TaskCreateRs.fromJsonFactory);

    return _apiTasksCreatePost(body: body);
  }

  ///Create Task
  @Post(
    path: '/api/tasks/create',
    optionalBody: true,
  )
  Future<chopper.Response<TaskCreateRs>> _apiTasksCreatePost(
      {@Body() required TaskCreateRq? body});

  ///To Planned
  Future<chopper.Response<TaskToPlanRs>> apiTasksToPlannedPut(
      {required TaskToPlanRq? body}) {
    generatedMapping.putIfAbsent(
        TaskToPlanRs, () => TaskToPlanRs.fromJsonFactory);

    return _apiTasksToPlannedPut(body: body);
  }

  ///To Planned
  @Put(
    path: '/api/tasks/to_planned',
    optionalBody: true,
  )
  Future<chopper.Response<TaskToPlanRs>> _apiTasksToPlannedPut(
      {@Body() required TaskToPlanRq? body});

  ///Get By Date
  ///@param data
  Future<chopper.Response<TaskListDateRs>> apiTasksGetDataGet(
      {required String? data}) {
    generatedMapping.putIfAbsent(
        TaskListDateRs, () => TaskListDateRs.fromJsonFactory);

    return _apiTasksGetDataGet(data: data);
  }

  ///Get By Date
  ///@param data
  @Get(path: '/api/tasks/get/{data}')
  Future<chopper.Response<TaskListDateRs>> _apiTasksGetDataGet(
      {@Path('data') required String? data});

  ///To Completed
  ///@param task_id
  Future<chopper.Response<TaskToPlanRs>> apiTasksToCompletedTaskIdPut(
      {required int? taskId}) {
    generatedMapping.putIfAbsent(
        TaskToPlanRs, () => TaskToPlanRs.fromJsonFactory);

    return _apiTasksToCompletedTaskIdPut(taskId: taskId);
  }

  ///To Completed
  ///@param task_id
  @Put(
    path: '/api/tasks/to_completed/{task_id}',
    optionalBody: true,
  )
  Future<chopper.Response<TaskToPlanRs>> _apiTasksToCompletedTaskIdPut(
      {@Path('task_id') required int? taskId});

  ///Delete Task
  ///@param task_id
  Future<chopper.Response<TaskToPlanRs>> apiTasksDeleteTaskIdDelete(
      {required int? taskId}) {
    generatedMapping.putIfAbsent(
        TaskToPlanRs, () => TaskToPlanRs.fromJsonFactory);

    return _apiTasksDeleteTaskIdDelete(taskId: taskId);
  }

  ///Delete Task
  ///@param task_id
  @Delete(path: '/api/tasks/delete/{task_id}')
  Future<chopper.Response<TaskToPlanRs>> _apiTasksDeleteTaskIdDelete(
      {@Path('task_id') required int? taskId});

  ///Get Unplanned
  Future<chopper.Response<TaskListRs>> apiTasksGetUnplannedGet() {
    generatedMapping.putIfAbsent(TaskListRs, () => TaskListRs.fromJsonFactory);

    return _apiTasksGetUnplannedGet();
  }

  ///Get Unplanned
  @Get(path: '/api/tasks/get_unplanned')
  Future<chopper.Response<TaskListRs>> _apiTasksGetUnplannedGet();

  ///Get Planned
  Future<chopper.Response<TaskListRs>> apiTasksGetPlannedGet() {
    generatedMapping.putIfAbsent(TaskListRs, () => TaskListRs.fromJsonFactory);

    return _apiTasksGetPlannedGet();
  }

  ///Get Planned
  @Get(path: '/api/tasks/get_planned')
  Future<chopper.Response<TaskListRs>> _apiTasksGetPlannedGet();

  ///Get Completed
  Future<chopper.Response<TaskListRs>> apiTasksGetCompletedGet() {
    generatedMapping.putIfAbsent(TaskListRs, () => TaskListRs.fromJsonFactory);

    return _apiTasksGetCompletedGet();
  }

  ///Get Completed
  @Get(path: '/api/tasks/get_completed')
  Future<chopper.Response<TaskListRs>> _apiTasksGetCompletedGet();

  ///Get By Id
  ///@param task_id
  Future<chopper.Response<TaskGetRs>> apiTasksGetByIdTaskIdGet(
      {required int? taskId}) {
    generatedMapping.putIfAbsent(TaskGetRs, () => TaskGetRs.fromJsonFactory);

    return _apiTasksGetByIdTaskIdGet(taskId: taskId);
  }

  ///Get By Id
  ///@param task_id
  @Get(path: '/api/tasks/get_by_id/{task_id}')
  Future<chopper.Response<TaskGetRs>> _apiTasksGetByIdTaskIdGet(
      {@Path('task_id') required int? taskId});
}

@JsonSerializable(explicitToJson: true)
class AdviceCreateRq {
  const AdviceCreateRq({
    required this.ids,
  });

  factory AdviceCreateRq.fromJson(Map<String, dynamic> json) =>
      _$AdviceCreateRqFromJson(json);

  static const toJsonFactory = _$AdviceCreateRqToJson;
  Map<String, dynamic> toJson() => _$AdviceCreateRqToJson(this);

  @JsonKey(name: 'ids', defaultValue: <int>[])
  final List<int> ids;
  static const fromJsonFactory = _$AdviceCreateRqFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdviceCreateRq &&
            (identical(other.ids, ids) ||
                const DeepCollectionEquality().equals(other.ids, ids)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(ids) ^ runtimeType.hashCode;
}

extension $AdviceCreateRqExtension on AdviceCreateRq {
  AdviceCreateRq copyWith({List<int>? ids}) {
    return AdviceCreateRq(ids: ids ?? this.ids);
  }

  AdviceCreateRq copyWithWrapped({Wrapped<List<int>>? ids}) {
    return AdviceCreateRq(ids: (ids != null ? ids.value : this.ids));
  }
}

@JsonSerializable(explicitToJson: true)
class AdviceCreateRs {
  const AdviceCreateRs({
    required this.id,
    required this.text,
    required this.color,
  });

  factory AdviceCreateRs.fromJson(Map<String, dynamic> json) =>
      _$AdviceCreateRsFromJson(json);

  static const toJsonFactory = _$AdviceCreateRsToJson;
  Map<String, dynamic> toJson() => _$AdviceCreateRsToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'text')
  final String text;
  @JsonKey(name: 'color')
  final String color;
  static const fromJsonFactory = _$AdviceCreateRsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdviceCreateRs &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(color) ^
      runtimeType.hashCode;
}

extension $AdviceCreateRsExtension on AdviceCreateRs {
  AdviceCreateRs copyWith({int? id, String? text, String? color}) {
    return AdviceCreateRs(
        id: id ?? this.id, text: text ?? this.text, color: color ?? this.color);
  }

  AdviceCreateRs copyWithWrapped(
      {Wrapped<int>? id, Wrapped<String>? text, Wrapped<String>? color}) {
    return AdviceCreateRs(
        id: (id != null ? id.value : this.id),
        text: (text != null ? text.value : this.text),
        color: (color != null ? color.value : this.color));
  }
}

@JsonSerializable(explicitToJson: true)
class AdviceGetRs {
  const AdviceGetRs({
    required this.advice,
  });

  factory AdviceGetRs.fromJson(Map<String, dynamic> json) =>
      _$AdviceGetRsFromJson(json);

  static const toJsonFactory = _$AdviceGetRsToJson;
  Map<String, dynamic> toJson() => _$AdviceGetRsToJson(this);

  @JsonKey(name: 'advice', defaultValue: <AdviceCreateRs>[])
  final List<AdviceCreateRs> advice;
  static const fromJsonFactory = _$AdviceGetRsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdviceGetRs &&
            (identical(other.advice, advice) ||
                const DeepCollectionEquality().equals(other.advice, advice)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(advice) ^ runtimeType.hashCode;
}

extension $AdviceGetRsExtension on AdviceGetRs {
  AdviceGetRs copyWith({List<AdviceCreateRs>? advice}) {
    return AdviceGetRs(advice: advice ?? this.advice);
  }

  AdviceGetRs copyWithWrapped({Wrapped<List<AdviceCreateRs>>? advice}) {
    return AdviceGetRs(advice: (advice != null ? advice.value : this.advice));
  }
}

@JsonSerializable(explicitToJson: true)
class FieldAnswer {
  const FieldAnswer({
    required this.status,
  });

  factory FieldAnswer.fromJson(Map<String, dynamic> json) =>
      _$FieldAnswerFromJson(json);

  static const toJsonFactory = _$FieldAnswerToJson;
  Map<String, dynamic> toJson() => _$FieldAnswerToJson(this);

  @JsonKey(name: 'status')
  final String status;
  static const fromJsonFactory = _$FieldAnswerFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FieldAnswer &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $FieldAnswerExtension on FieldAnswer {
  FieldAnswer copyWith({String? status}) {
    return FieldAnswer(status: status ?? this.status);
  }

  FieldAnswer copyWithWrapped({Wrapped<String>? status}) {
    return FieldAnswer(status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class FieldInput {
  const FieldInput({
    required this.date,
    required this.list,
  });

  factory FieldInput.fromJson(Map<String, dynamic> json) =>
      _$FieldInputFromJson(json);

  static const toJsonFactory = _$FieldInputToJson;
  Map<String, dynamic> toJson() => _$FieldInputToJson(this);

  @JsonKey(name: 'date', toJson: _dateToJson)
  final DateTime date;
  @JsonKey(name: 'list', defaultValue: <List<int?>>[])
  final List<List<int?>> list;
  static const fromJsonFactory = _$FieldInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FieldInput &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.list, list) ||
                const DeepCollectionEquality().equals(other.list, list)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(list) ^
      runtimeType.hashCode;
}

extension $FieldInputExtension on FieldInput {
  FieldInput copyWith({DateTime? date, List<List<int?>>? list}) {
    return FieldInput(date: date ?? this.date, list: list ?? this.list);
  }

  FieldInput copyWithWrapped(
      {Wrapped<DateTime>? date, Wrapped<List<List<int?>>>? list}) {
    return FieldInput(
        date: (date != null ? date.value : this.date),
        list: (list != null ? list.value : this.list));
  }
}

@JsonSerializable(explicitToJson: true)
class FieldOutput {
  const FieldOutput({
    required this.date,
    required this.matrix,
    required this.info,
  });

  factory FieldOutput.fromJson(Map<String, dynamic> json) =>
      _$FieldOutputFromJson(json);

  static const toJsonFactory = _$FieldOutputToJson;
  Map<String, dynamic> toJson() => _$FieldOutputToJson(this);

  @JsonKey(name: 'date', toJson: _dateToJson)
  final DateTime date;
  @JsonKey(name: 'matrix', defaultValue: <List<int?>>[])
  final List<List<int?>> matrix;
  @JsonKey(name: 'info', defaultValue: <TaskInfo>[])
  final List<TaskInfo> info;
  static const fromJsonFactory = _$FieldOutputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FieldOutput &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.matrix, matrix) ||
                const DeepCollectionEquality().equals(other.matrix, matrix)) &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(matrix) ^
      const DeepCollectionEquality().hash(info) ^
      runtimeType.hashCode;
}

extension $FieldOutputExtension on FieldOutput {
  FieldOutput copyWith(
      {DateTime? date, List<List<int?>>? matrix, List<TaskInfo>? info}) {
    return FieldOutput(
        date: date ?? this.date,
        matrix: matrix ?? this.matrix,
        info: info ?? this.info);
  }

  FieldOutput copyWithWrapped(
      {Wrapped<DateTime>? date,
      Wrapped<List<List<int?>>>? matrix,
      Wrapped<List<TaskInfo>>? info}) {
    return FieldOutput(
        date: (date != null ? date.value : this.date),
        matrix: (matrix != null ? matrix.value : this.matrix),
        info: (info != null ? info.value : this.info));
  }
}

@JsonSerializable(explicitToJson: true)
class HTTPValidationError {
  const HTTPValidationError({
    this.detail,
  });

  factory HTTPValidationError.fromJson(Map<String, dynamic> json) =>
      _$HTTPValidationErrorFromJson(json);

  static const toJsonFactory = _$HTTPValidationErrorToJson;
  Map<String, dynamic> toJson() => _$HTTPValidationErrorToJson(this);

  @JsonKey(name: 'detail', defaultValue: <ValidationError>[])
  final List<ValidationError>? detail;
  static const fromJsonFactory = _$HTTPValidationErrorFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is HTTPValidationError &&
            (identical(other.detail, detail) ||
                const DeepCollectionEquality().equals(other.detail, detail)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(detail) ^ runtimeType.hashCode;
}

extension $HTTPValidationErrorExtension on HTTPValidationError {
  HTTPValidationError copyWith({List<ValidationError>? detail}) {
    return HTTPValidationError(detail: detail ?? this.detail);
  }

  HTTPValidationError copyWithWrapped(
      {Wrapped<List<ValidationError>?>? detail}) {
    return HTTPValidationError(
        detail: (detail != null ? detail.value : this.detail));
  }
}

@JsonSerializable(explicitToJson: true)
class HealthcheckPingRs {
  const HealthcheckPingRs({
    required this.status,
    required this.responseTime,
  });

  factory HealthcheckPingRs.fromJson(Map<String, dynamic> json) =>
      _$HealthcheckPingRsFromJson(json);

  static const toJsonFactory = _$HealthcheckPingRsToJson;
  Map<String, dynamic> toJson() => _$HealthcheckPingRsToJson(this);

  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'response_time')
  final double responseTime;
  static const fromJsonFactory = _$HealthcheckPingRsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is HealthcheckPingRs &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.responseTime, responseTime) ||
                const DeepCollectionEquality()
                    .equals(other.responseTime, responseTime)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(responseTime) ^
      runtimeType.hashCode;
}

extension $HealthcheckPingRsExtension on HealthcheckPingRs {
  HealthcheckPingRs copyWith({String? status, double? responseTime}) {
    return HealthcheckPingRs(
        status: status ?? this.status,
        responseTime: responseTime ?? this.responseTime);
  }

  HealthcheckPingRs copyWithWrapped(
      {Wrapped<String>? status, Wrapped<double>? responseTime}) {
    return HealthcheckPingRs(
        status: (status != null ? status.value : this.status),
        responseTime:
            (responseTime != null ? responseTime.value : this.responseTime));
  }
}

@JsonSerializable(explicitToJson: true)
class SubTask {
  const SubTask({
    required this.name,
    required this.duration,
  });

  factory SubTask.fromJson(Map<String, dynamic> json) =>
      _$SubTaskFromJson(json);

  static const toJsonFactory = _$SubTaskToJson;
  Map<String, dynamic> toJson() => _$SubTaskToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'duration')
  final String duration;
  static const fromJsonFactory = _$SubTaskFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SubTask &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(duration) ^
      runtimeType.hashCode;
}

extension $SubTaskExtension on SubTask {
  SubTask copyWith({String? name, String? duration}) {
    return SubTask(
        name: name ?? this.name, duration: duration ?? this.duration);
  }

  SubTask copyWithWrapped({Wrapped<String>? name, Wrapped<String>? duration}) {
    return SubTask(
        name: (name != null ? name.value : this.name),
        duration: (duration != null ? duration.value : this.duration));
  }
}

@JsonSerializable(explicitToJson: true)
class TaskCreateRq {
  const TaskCreateRq({
    required this.type,
    required this.name,
    required this.description,
    this.duration,
    required this.importance,
    required this.category,
    this.subtasks,
  });

  factory TaskCreateRq.fromJson(Map<String, dynamic> json) =>
      _$TaskCreateRqFromJson(json);

  static const toJsonFactory = _$TaskCreateRqToJson;
  Map<String, dynamic> toJson() => _$TaskCreateRqToJson(this);

  @JsonKey(
    name: 'type',
    toJson: type$ToJson,
    fromJson: type$FromJson,
  )
  final enums.Type$ type;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'duration')
  final String? duration;
  @JsonKey(name: 'importance')
  final bool importance;
  @JsonKey(
    name: 'category',
    toJson: taskCategoryToJson,
    fromJson: taskCategoryFromJson,
  )
  final enums.TaskCategory category;
  @JsonKey(name: 'subtasks', defaultValue: <SubTask>[])
  final List<SubTask>? subtasks;
  static const fromJsonFactory = _$TaskCreateRqFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TaskCreateRq &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.importance, importance) ||
                const DeepCollectionEquality()
                    .equals(other.importance, importance)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.subtasks, subtasks) ||
                const DeepCollectionEquality()
                    .equals(other.subtasks, subtasks)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(importance) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(subtasks) ^
      runtimeType.hashCode;
}

extension $TaskCreateRqExtension on TaskCreateRq {
  TaskCreateRq copyWith(
      {enums.Type$? type,
      String? name,
      String? description,
      String? duration,
      bool? importance,
      enums.TaskCategory? category,
      List<SubTask>? subtasks}) {
    return TaskCreateRq(
        type: type ?? this.type,
        name: name ?? this.name,
        description: description ?? this.description,
        duration: duration ?? this.duration,
        importance: importance ?? this.importance,
        category: category ?? this.category,
        subtasks: subtasks ?? this.subtasks);
  }

  TaskCreateRq copyWithWrapped(
      {Wrapped<enums.Type$>? type,
      Wrapped<String>? name,
      Wrapped<String>? description,
      Wrapped<String?>? duration,
      Wrapped<bool>? importance,
      Wrapped<enums.TaskCategory>? category,
      Wrapped<List<SubTask>?>? subtasks}) {
    return TaskCreateRq(
        type: (type != null ? type.value : this.type),
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        duration: (duration != null ? duration.value : this.duration),
        importance: (importance != null ? importance.value : this.importance),
        category: (category != null ? category.value : this.category),
        subtasks: (subtasks != null ? subtasks.value : this.subtasks));
  }
}

@JsonSerializable(explicitToJson: true)
class TaskCreateRs {
  const TaskCreateRs({
    required this.taskId,
  });

  factory TaskCreateRs.fromJson(Map<String, dynamic> json) =>
      _$TaskCreateRsFromJson(json);

  static const toJsonFactory = _$TaskCreateRsToJson;
  Map<String, dynamic> toJson() => _$TaskCreateRsToJson(this);

  @JsonKey(name: 'task_id')
  final int taskId;
  static const fromJsonFactory = _$TaskCreateRsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TaskCreateRs &&
            (identical(other.taskId, taskId) ||
                const DeepCollectionEquality().equals(other.taskId, taskId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(taskId) ^ runtimeType.hashCode;
}

extension $TaskCreateRsExtension on TaskCreateRs {
  TaskCreateRs copyWith({int? taskId}) {
    return TaskCreateRs(taskId: taskId ?? this.taskId);
  }

  TaskCreateRs copyWithWrapped({Wrapped<int>? taskId}) {
    return TaskCreateRs(taskId: (taskId != null ? taskId.value : this.taskId));
  }
}

@JsonSerializable(explicitToJson: true)
class TaskGetRs {
  const TaskGetRs({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.duration,
    required this.importance,
    required this.isMulti,
    required this.multiId,
    required this.multiColor,
    required this.multiName,
    required this.multiDescription,
  });

  factory TaskGetRs.fromJson(Map<String, dynamic> json) =>
      _$TaskGetRsFromJson(json);

  static const toJsonFactory = _$TaskGetRsToJson;
  Map<String, dynamic> toJson() => _$TaskGetRsToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(
    name: 'category',
    toJson: taskCategoryToJson,
    fromJson: taskCategoryFromJson,
  )
  final enums.TaskCategory category;
  @JsonKey(name: 'duration')
  final String duration;
  @JsonKey(name: 'importance')
  final bool importance;
  @JsonKey(name: 'is_multi')
  final bool isMulti;
  @JsonKey(name: 'multi_id')
  final dynamic multiId;
  @JsonKey(name: 'multi_color')
  final dynamic multiColor;
  @JsonKey(name: 'multi_name')
  final dynamic multiName;
  @JsonKey(name: 'multi_description')
  final dynamic multiDescription;
  static const fromJsonFactory = _$TaskGetRsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TaskGetRs &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.importance, importance) ||
                const DeepCollectionEquality()
                    .equals(other.importance, importance)) &&
            (identical(other.isMulti, isMulti) ||
                const DeepCollectionEquality()
                    .equals(other.isMulti, isMulti)) &&
            (identical(other.multiId, multiId) ||
                const DeepCollectionEquality()
                    .equals(other.multiId, multiId)) &&
            (identical(other.multiColor, multiColor) ||
                const DeepCollectionEquality()
                    .equals(other.multiColor, multiColor)) &&
            (identical(other.multiName, multiName) ||
                const DeepCollectionEquality()
                    .equals(other.multiName, multiName)) &&
            (identical(other.multiDescription, multiDescription) ||
                const DeepCollectionEquality()
                    .equals(other.multiDescription, multiDescription)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(importance) ^
      const DeepCollectionEquality().hash(isMulti) ^
      const DeepCollectionEquality().hash(multiId) ^
      const DeepCollectionEquality().hash(multiColor) ^
      const DeepCollectionEquality().hash(multiName) ^
      const DeepCollectionEquality().hash(multiDescription) ^
      runtimeType.hashCode;
}

extension $TaskGetRsExtension on TaskGetRs {
  TaskGetRs copyWith(
      {int? id,
      String? name,
      String? description,
      enums.TaskCategory? category,
      String? duration,
      bool? importance,
      bool? isMulti,
      dynamic multiId,
      dynamic multiColor,
      dynamic multiName,
      dynamic multiDescription}) {
    return TaskGetRs(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
        duration: duration ?? this.duration,
        importance: importance ?? this.importance,
        isMulti: isMulti ?? this.isMulti,
        multiId: multiId ?? this.multiId,
        multiColor: multiColor ?? this.multiColor,
        multiName: multiName ?? this.multiName,
        multiDescription: multiDescription ?? this.multiDescription);
  }

  TaskGetRs copyWithWrapped(
      {Wrapped<int>? id,
      Wrapped<String>? name,
      Wrapped<String>? description,
      Wrapped<enums.TaskCategory>? category,
      Wrapped<String>? duration,
      Wrapped<bool>? importance,
      Wrapped<bool>? isMulti,
      Wrapped<dynamic>? multiId,
      Wrapped<dynamic>? multiColor,
      Wrapped<dynamic>? multiName,
      Wrapped<dynamic>? multiDescription}) {
    return TaskGetRs(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        category: (category != null ? category.value : this.category),
        duration: (duration != null ? duration.value : this.duration),
        importance: (importance != null ? importance.value : this.importance),
        isMulti: (isMulti != null ? isMulti.value : this.isMulti),
        multiId: (multiId != null ? multiId.value : this.multiId),
        multiColor: (multiColor != null ? multiColor.value : this.multiColor),
        multiName: (multiName != null ? multiName.value : this.multiName),
        multiDescription: (multiDescription != null
            ? multiDescription.value
            : this.multiDescription));
  }
}

@JsonSerializable(explicitToJson: true)
class TaskInfo {
  const TaskInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.duration,
    required this.importance,
    required this.isMulti,
    required this.multiId,
    required this.multiColor,
    required this.multiName,
    required this.multiDescription,
  });

  factory TaskInfo.fromJson(Map<String, dynamic> json) =>
      _$TaskInfoFromJson(json);

  static const toJsonFactory = _$TaskInfoToJson;
  Map<String, dynamic> toJson() => _$TaskInfoToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(
    name: 'category',
    toJson: taskCategoryToJson,
    fromJson: taskCategoryFromJson,
  )
  final enums.TaskCategory category;
  @JsonKey(name: 'duration')
  final String duration;
  @JsonKey(name: 'importance')
  final bool importance;
  @JsonKey(name: 'is_multi')
  final bool isMulti;
  @JsonKey(name: 'multi_id')
  final dynamic multiId;
  @JsonKey(name: 'multi_color')
  final dynamic multiColor;
  @JsonKey(name: 'multi_name')
  final dynamic multiName;
  @JsonKey(name: 'multi_description')
  final dynamic multiDescription;
  static const fromJsonFactory = _$TaskInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TaskInfo &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.importance, importance) ||
                const DeepCollectionEquality()
                    .equals(other.importance, importance)) &&
            (identical(other.isMulti, isMulti) ||
                const DeepCollectionEquality()
                    .equals(other.isMulti, isMulti)) &&
            (identical(other.multiId, multiId) ||
                const DeepCollectionEquality()
                    .equals(other.multiId, multiId)) &&
            (identical(other.multiColor, multiColor) ||
                const DeepCollectionEquality()
                    .equals(other.multiColor, multiColor)) &&
            (identical(other.multiName, multiName) ||
                const DeepCollectionEquality()
                    .equals(other.multiName, multiName)) &&
            (identical(other.multiDescription, multiDescription) ||
                const DeepCollectionEquality()
                    .equals(other.multiDescription, multiDescription)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(importance) ^
      const DeepCollectionEquality().hash(isMulti) ^
      const DeepCollectionEquality().hash(multiId) ^
      const DeepCollectionEquality().hash(multiColor) ^
      const DeepCollectionEquality().hash(multiName) ^
      const DeepCollectionEquality().hash(multiDescription) ^
      runtimeType.hashCode;
}

extension $TaskInfoExtension on TaskInfo {
  TaskInfo copyWith(
      {int? id,
      String? name,
      String? description,
      enums.TaskCategory? category,
      String? duration,
      bool? importance,
      bool? isMulti,
      dynamic multiId,
      dynamic multiColor,
      dynamic multiName,
      dynamic multiDescription}) {
    return TaskInfo(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
        duration: duration ?? this.duration,
        importance: importance ?? this.importance,
        isMulti: isMulti ?? this.isMulti,
        multiId: multiId ?? this.multiId,
        multiColor: multiColor ?? this.multiColor,
        multiName: multiName ?? this.multiName,
        multiDescription: multiDescription ?? this.multiDescription);
  }

  TaskInfo copyWithWrapped(
      {Wrapped<int>? id,
      Wrapped<String>? name,
      Wrapped<String>? description,
      Wrapped<enums.TaskCategory>? category,
      Wrapped<String>? duration,
      Wrapped<bool>? importance,
      Wrapped<bool>? isMulti,
      Wrapped<dynamic>? multiId,
      Wrapped<dynamic>? multiColor,
      Wrapped<dynamic>? multiName,
      Wrapped<dynamic>? multiDescription}) {
    return TaskInfo(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        category: (category != null ? category.value : this.category),
        duration: (duration != null ? duration.value : this.duration),
        importance: (importance != null ? importance.value : this.importance),
        isMulti: (isMulti != null ? isMulti.value : this.isMulti),
        multiId: (multiId != null ? multiId.value : this.multiId),
        multiColor: (multiColor != null ? multiColor.value : this.multiColor),
        multiName: (multiName != null ? multiName.value : this.multiName),
        multiDescription: (multiDescription != null
            ? multiDescription.value
            : this.multiDescription));
  }
}

@JsonSerializable(explicitToJson: true)
class TaskList {
  const TaskList({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
  });

  factory TaskList.fromJson(Map<String, dynamic> json) =>
      _$TaskListFromJson(json);

  static const toJsonFactory = _$TaskListToJson;
  Map<String, dynamic> toJson() => _$TaskListToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'duration')
  final String duration;
  static const fromJsonFactory = _$TaskListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TaskList &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(duration) ^
      runtimeType.hashCode;
}

extension $TaskListExtension on TaskList {
  TaskList copyWith(
      {int? id, String? name, String? description, String? duration}) {
    return TaskList(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        duration: duration ?? this.duration);
  }

  TaskList copyWithWrapped(
      {Wrapped<int>? id,
      Wrapped<String>? name,
      Wrapped<String>? description,
      Wrapped<String>? duration}) {
    return TaskList(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        duration: (duration != null ? duration.value : this.duration));
  }
}

@JsonSerializable(explicitToJson: true)
class TaskListDate {
  const TaskListDate({
    required this.id,
    required this.name,
  });

  factory TaskListDate.fromJson(Map<String, dynamic> json) =>
      _$TaskListDateFromJson(json);

  static const toJsonFactory = _$TaskListDateToJson;
  Map<String, dynamic> toJson() => _$TaskListDateToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$TaskListDateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TaskListDate &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $TaskListDateExtension on TaskListDate {
  TaskListDate copyWith({int? id, String? name}) {
    return TaskListDate(id: id ?? this.id, name: name ?? this.name);
  }

  TaskListDate copyWithWrapped({Wrapped<int>? id, Wrapped<String>? name}) {
    return TaskListDate(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class TaskListDateRs {
  const TaskListDateRs({
    required this.plannedTasks,
    required this.completedTasks,
  });

  factory TaskListDateRs.fromJson(Map<String, dynamic> json) =>
      _$TaskListDateRsFromJson(json);

  static const toJsonFactory = _$TaskListDateRsToJson;
  Map<String, dynamic> toJson() => _$TaskListDateRsToJson(this);

  @JsonKey(name: 'planned_tasks', defaultValue: <TaskListDate>[])
  final List<TaskListDate> plannedTasks;
  @JsonKey(name: 'completed_tasks', defaultValue: <TaskListDate>[])
  final List<TaskListDate> completedTasks;
  static const fromJsonFactory = _$TaskListDateRsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TaskListDateRs &&
            (identical(other.plannedTasks, plannedTasks) ||
                const DeepCollectionEquality()
                    .equals(other.plannedTasks, plannedTasks)) &&
            (identical(other.completedTasks, completedTasks) ||
                const DeepCollectionEquality()
                    .equals(other.completedTasks, completedTasks)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(plannedTasks) ^
      const DeepCollectionEquality().hash(completedTasks) ^
      runtimeType.hashCode;
}

extension $TaskListDateRsExtension on TaskListDateRs {
  TaskListDateRs copyWith(
      {List<TaskListDate>? plannedTasks, List<TaskListDate>? completedTasks}) {
    return TaskListDateRs(
        plannedTasks: plannedTasks ?? this.plannedTasks,
        completedTasks: completedTasks ?? this.completedTasks);
  }

  TaskListDateRs copyWithWrapped(
      {Wrapped<List<TaskListDate>>? plannedTasks,
      Wrapped<List<TaskListDate>>? completedTasks}) {
    return TaskListDateRs(
        plannedTasks:
            (plannedTasks != null ? plannedTasks.value : this.plannedTasks),
        completedTasks: (completedTasks != null
            ? completedTasks.value
            : this.completedTasks));
  }
}

@JsonSerializable(explicitToJson: true)
class TaskListRs {
  const TaskListRs({
    required this.tasks,
  });

  factory TaskListRs.fromJson(Map<String, dynamic> json) =>
      _$TaskListRsFromJson(json);

  static const toJsonFactory = _$TaskListRsToJson;
  Map<String, dynamic> toJson() => _$TaskListRsToJson(this);

  @JsonKey(name: 'tasks', defaultValue: <TaskList>[])
  final List<TaskList> tasks;
  static const fromJsonFactory = _$TaskListRsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TaskListRs &&
            (identical(other.tasks, tasks) ||
                const DeepCollectionEquality().equals(other.tasks, tasks)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(tasks) ^ runtimeType.hashCode;
}

extension $TaskListRsExtension on TaskListRs {
  TaskListRs copyWith({List<TaskList>? tasks}) {
    return TaskListRs(tasks: tasks ?? this.tasks);
  }

  TaskListRs copyWithWrapped({Wrapped<List<TaskList>>? tasks}) {
    return TaskListRs(tasks: (tasks != null ? tasks.value : this.tasks));
  }
}

@JsonSerializable(explicitToJson: true)
class TaskToPlanRq {
  const TaskToPlanRq({
    required this.date,
    required this.tasks,
  });

  factory TaskToPlanRq.fromJson(Map<String, dynamic> json) =>
      _$TaskToPlanRqFromJson(json);

  static const toJsonFactory = _$TaskToPlanRqToJson;
  Map<String, dynamic> toJson() => _$TaskToPlanRqToJson(this);

  @JsonKey(name: 'date', toJson: _dateToJson)
  final DateTime date;
  @JsonKey(name: 'tasks', defaultValue: <int>[])
  final List<int> tasks;
  static const fromJsonFactory = _$TaskToPlanRqFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TaskToPlanRq &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.tasks, tasks) ||
                const DeepCollectionEquality().equals(other.tasks, tasks)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(tasks) ^
      runtimeType.hashCode;
}

extension $TaskToPlanRqExtension on TaskToPlanRq {
  TaskToPlanRq copyWith({DateTime? date, List<int>? tasks}) {
    return TaskToPlanRq(date: date ?? this.date, tasks: tasks ?? this.tasks);
  }

  TaskToPlanRq copyWithWrapped(
      {Wrapped<DateTime>? date, Wrapped<List<int>>? tasks}) {
    return TaskToPlanRq(
        date: (date != null ? date.value : this.date),
        tasks: (tasks != null ? tasks.value : this.tasks));
  }
}

@JsonSerializable(explicitToJson: true)
class TaskToPlanRs {
  const TaskToPlanRs({
    required this.status,
  });

  factory TaskToPlanRs.fromJson(Map<String, dynamic> json) =>
      _$TaskToPlanRsFromJson(json);

  static const toJsonFactory = _$TaskToPlanRsToJson;
  Map<String, dynamic> toJson() => _$TaskToPlanRsToJson(this);

  @JsonKey(name: 'status')
  final String status;
  static const fromJsonFactory = _$TaskToPlanRsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TaskToPlanRs &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $TaskToPlanRsExtension on TaskToPlanRs {
  TaskToPlanRs copyWith({String? status}) {
    return TaskToPlanRs(status: status ?? this.status);
  }

  TaskToPlanRs copyWithWrapped({Wrapped<String>? status}) {
    return TaskToPlanRs(status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class ValidationError {
  const ValidationError({
    required this.loc,
    required this.msg,
    required this.type,
  });

  factory ValidationError.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorFromJson(json);

  static const toJsonFactory = _$ValidationErrorToJson;
  Map<String, dynamic> toJson() => _$ValidationErrorToJson(this);

  @JsonKey(name: 'loc', defaultValue: <Object>[])
  final List<Object> loc;
  @JsonKey(name: 'msg')
  final String msg;
  @JsonKey(name: 'type')
  final String type;
  static const fromJsonFactory = _$ValidationErrorFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ValidationError &&
            (identical(other.loc, loc) ||
                const DeepCollectionEquality().equals(other.loc, loc)) &&
            (identical(other.msg, msg) ||
                const DeepCollectionEquality().equals(other.msg, msg)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(loc) ^
      const DeepCollectionEquality().hash(msg) ^
      const DeepCollectionEquality().hash(type) ^
      runtimeType.hashCode;
}

extension $ValidationErrorExtension on ValidationError {
  ValidationError copyWith({List<Object>? loc, String? msg, String? type}) {
    return ValidationError(
        loc: loc ?? this.loc, msg: msg ?? this.msg, type: type ?? this.type);
  }

  ValidationError copyWithWrapped(
      {Wrapped<List<Object>>? loc,
      Wrapped<String>? msg,
      Wrapped<String>? type}) {
    return ValidationError(
        loc: (loc != null ? loc.value : this.loc),
        msg: (msg != null ? msg.value : this.msg),
        type: (type != null ? type.value : this.type));
  }
}

String? taskCategoryNullableToJson(enums.TaskCategory? taskCategory) {
  return taskCategory?.value;
}

String? taskCategoryToJson(enums.TaskCategory taskCategory) {
  return taskCategory.value;
}

enums.TaskCategory taskCategoryFromJson(
  Object? taskCategory, [
  enums.TaskCategory? defaultValue,
]) {
  return enums.TaskCategory.values
          .firstWhereOrNull((e) => e.value == taskCategory) ??
      defaultValue ??
      enums.TaskCategory.swaggerGeneratedUnknown;
}

enums.TaskCategory? taskCategoryNullableFromJson(
  Object? taskCategory, [
  enums.TaskCategory? defaultValue,
]) {
  if (taskCategory == null) {
    return null;
  }
  return enums.TaskCategory.values
          .firstWhereOrNull((e) => e.value == taskCategory) ??
      defaultValue;
}

String taskCategoryExplodedListToJson(List<enums.TaskCategory>? taskCategory) {
  return taskCategory?.map((e) => e.value!).join(',') ?? '';
}

List<String> taskCategoryListToJson(List<enums.TaskCategory>? taskCategory) {
  if (taskCategory == null) {
    return [];
  }

  return taskCategory.map((e) => e.value!).toList();
}

List<enums.TaskCategory> taskCategoryListFromJson(
  List? taskCategory, [
  List<enums.TaskCategory>? defaultValue,
]) {
  if (taskCategory == null) {
    return defaultValue ?? [];
  }

  return taskCategory.map((e) => taskCategoryFromJson(e.toString())).toList();
}

List<enums.TaskCategory>? taskCategoryNullableListFromJson(
  List? taskCategory, [
  List<enums.TaskCategory>? defaultValue,
]) {
  if (taskCategory == null) {
    return defaultValue;
  }

  return taskCategory.map((e) => taskCategoryFromJson(e.toString())).toList();
}

String? type$NullableToJson(enums.Type$? type$) {
  return type$?.value;
}

String? type$ToJson(enums.Type$ type$) {
  return type$.value;
}

enums.Type$ type$FromJson(
  Object? type$, [
  enums.Type$? defaultValue,
]) {
  return enums.Type$.values.firstWhereOrNull((e) => e.value == type$) ??
      defaultValue ??
      enums.Type$.swaggerGeneratedUnknown;
}

enums.Type$? type$NullableFromJson(
  Object? type$, [
  enums.Type$? defaultValue,
]) {
  if (type$ == null) {
    return null;
  }
  return enums.Type$.values.firstWhereOrNull((e) => e.value == type$) ??
      defaultValue;
}

String type$ExplodedListToJson(List<enums.Type$>? type$) {
  return type$?.map((e) => e.value!).join(',') ?? '';
}

List<String> type$ListToJson(List<enums.Type$>? type$) {
  if (type$ == null) {
    return [];
  }

  return type$.map((e) => e.value!).toList();
}

List<enums.Type$> type$ListFromJson(
  List? type$, [
  List<enums.Type$>? defaultValue,
]) {
  if (type$ == null) {
    return defaultValue ?? [];
  }

  return type$.map((e) => type$FromJson(e.toString())).toList();
}

List<enums.Type$>? type$NullableListFromJson(
  List? type$, [
  List<enums.Type$>? defaultValue,
]) {
  if (type$ == null) {
    return defaultValue;
  }

  return type$.map((e) => type$FromJson(e.toString())).toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
