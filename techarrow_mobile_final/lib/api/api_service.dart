import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:techarrow_mobile_final/auth/keycloak.dart';
import 'package:techarrow_mobile_final/enums/task_types.dart';
import 'package:techarrow_mobile_final/screens/task_creation/features/task_creation_features.dart';
import 'package:techarrow_mobile_final/swagger_generated_api/client_index.dart';
import 'package:techarrow_mobile_final/swagger_generated_api/swagger.swagger.dart';
import 'package:techarrow_mobile_final/utils/matrix.dart';
import 'package:techarrow_mobile_final/utils/task.dart';

class ApiService {
  static final api = Swagger.create(
      baseUrl: Uri.parse('https://api.penki.tech'),
      interceptors: [AuthInterceptor()]);

  static Future<void> postTask(
      {required String title,
      required String description,
      required TaskTypes type,
      required bool isImportant,
      Duration? duration,
      List<Subtask>? subtasks}) async {
    var mtype = subtasks == null ? Type$.unplanned : Type$.multifaceted;
    var mduration = "${duration!.inHours}:${duration.inMinutes.remainder(60)}";
    var category = taskTypeToTaskCategory(type);
    var msubtasks = subtasks
        ?.map((e) => SubTask(
            name: e.title,
            duration:
                "${e.duration.inHours}:${e.duration.inMinutes.remainder(60)}"))
        .toList();
    var body = TaskCreateRq(
        type: mtype,
        name: title,
        description: description,
        duration: mduration,
        importance: isImportant,
        category: category,
        subtasks: msubtasks ?? []);

    print(body);

    var res = await ApiService.api.apiTasksCreatePost(body: body);

    print(res);
    print(res.statusCode);
  }

  static Future<List<Task>> getUnplannedTasks() async {
    var res = await ApiService.api.apiTasksGetUnplannedGet();
    var tasks = res.body?.tasks;
    print(tasks);
    return List.generate(
      tasks?.length ?? 0,
      (index) => Task(
          tasks![index].id,
          tasks[index].name,
          tasks[index].description,
          0,
          int.parse(tasks[index].duration.split(":")[0]),
          0,
          status: TaskStatus.scheduled),
    );
  }

  static Future getPlannedTasks() async {
    var res = await ApiService.api.apiTasksGetPlannedGet();
    var tasks = res.body?.tasks;
    print(tasks);
    return List.generate(
      tasks?.length ?? 0,
      (index) => Task(
          tasks![index].id,
          tasks[index].name,
          tasks[index].description,
          0,
          int.parse(tasks[index].duration.split(":")[0]),
          0,
          status: TaskStatus.scheduled),
    );
  }

  static Future getCompletedTasks() async {
    var res = await ApiService.api.apiTasksGetCompletedGet();
    var tasks = res.body?.tasks;
    print(tasks);
    return List.generate(
      tasks?.length ?? 0,
      (index) => Task(tasks![index].id, tasks[index].name,
          tasks[index].description, 0, 0, 0,
          status: TaskStatus.done),
    );
  }

  static Future postTasksToPlanned(DateTime date, List<Task> tasks) async {
    var body = TaskToPlanRq(
      date: date,
      tasks: tasks.map((e) => e.id).toList(),
    );

    await ApiService.api.apiTasksToPlannedPut(body: body);
  }

  static Future postMatrix(Matrix matrix, DateTime date) async {
    var body = FieldInput(
      date: date,
      list: (matrix.matrix.map((e) => (e.map((el) => el.number)).toList()))
          .toList(),
    );

    print(body.list);

    await ApiService.api.apiFieldsUpdatePut(body: body);
  }
}

class AuthInterceptor implements HeadersInterceptor {
  AuthInterceptor();

  @override
  Map<String, String> get headers => {'Authorization': "Bearer token"};

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    if (await Keycloak().isTokenExpired()) {
      await Keycloak().refreshToken();
    }
    chain.request.headers['Authorization'] =
        'Bearer ${await FlutterSecureStorage().read(key: "access_token")}';
    return chain.proceed(chain.request);
  }
}
