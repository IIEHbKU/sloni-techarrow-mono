//Generated code

part of 'swagger.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Swagger extends Swagger {
  _$Swagger([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Swagger;

  @override
  Future<Response<AdviceCreateRs>> _apiAdviceCreatePost(
      {required AdviceCreateRq? body}) {
    final Uri $url = Uri.parse('/api/advice/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AdviceCreateRs, AdviceCreateRs>($request);
  }

  @override
  Future<Response<AdviceGetRs>> _apiAdviceGetGet() {
    final Uri $url = Uri.parse('/api/advice/get');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<AdviceGetRs, AdviceGetRs>($request);
  }

  @override
  Future<Response<FieldAnswer>> _apiFieldsUpdatePut(
      {required FieldInput? body}) {
    final Uri $url = Uri.parse('/api/fields/update');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<FieldAnswer, FieldAnswer>($request);
  }

  @override
  Future<Response<FieldOutput>> _apiFieldsGetDateGet({required String? date}) {
    final Uri $url = Uri.parse('/api/fields/get/${date}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<FieldOutput, FieldOutput>($request);
  }

  @override
  Future<Response<HealthcheckPingRs>> _apiPingGet() {
    final Uri $url = Uri.parse('/api/ping');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<HealthcheckPingRs, HealthcheckPingRs>($request);
  }

  @override
  Future<Response<TaskCreateRs>> _apiTasksCreatePost(
      {required TaskCreateRq? body}) {
    final Uri $url = Uri.parse('/api/tasks/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TaskCreateRs, TaskCreateRs>($request);
  }

  @override
  Future<Response<TaskToPlanRs>> _apiTasksToPlannedPut(
      {required TaskToPlanRq? body}) {
    final Uri $url = Uri.parse('/api/tasks/to_planned');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TaskToPlanRs, TaskToPlanRs>($request);
  }

  @override
  Future<Response<TaskListDateRs>> _apiTasksGetDataGet(
      {required String? data}) {
    final Uri $url = Uri.parse('/api/tasks/get/${data}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TaskListDateRs, TaskListDateRs>($request);
  }

  @override
  Future<Response<TaskToPlanRs>> _apiTasksToCompletedTaskIdPut(
      {required int? taskId}) {
    final Uri $url = Uri.parse('/api/tasks/to_completed/${taskId}');
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
    );
    return client.send<TaskToPlanRs, TaskToPlanRs>($request);
  }

  @override
  Future<Response<TaskToPlanRs>> _apiTasksDeleteTaskIdDelete(
      {required int? taskId}) {
    final Uri $url = Uri.parse('/api/tasks/delete/${taskId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<TaskToPlanRs, TaskToPlanRs>($request);
  }

  @override
  Future<Response<TaskListRs>> _apiTasksGetUnplannedGet() {
    final Uri $url = Uri.parse('/api/tasks/get_unplanned');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TaskListRs, TaskListRs>($request);
  }

  @override
  Future<Response<TaskListRs>> _apiTasksGetPlannedGet() {
    final Uri $url = Uri.parse('/api/tasks/get_planned');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TaskListRs, TaskListRs>($request);
  }

  @override
  Future<Response<TaskListRs>> _apiTasksGetCompletedGet() {
    final Uri $url = Uri.parse('/api/tasks/get_completed');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TaskListRs, TaskListRs>($request);
  }

  @override
  Future<Response<TaskGetRs>> _apiTasksGetByIdTaskIdGet(
      {required int? taskId}) {
    final Uri $url = Uri.parse('/api/tasks/get_by_id/${taskId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TaskGetRs, TaskGetRs>($request);
  }
}
