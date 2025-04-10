import 'package:flutter/material.dart';
import 'package:techarrow_mobile_final/api/api_service.dart';
import 'package:techarrow_mobile_final/enums/task_types.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                ApiService.postTask(
                    title: "asdef",
                    description: "egwgweg",
                    type: TaskTypes.work,
                    isImportant: true,
                    duration: Duration(hours: 1));
              },
              child: Text("test"))),
    );
  }
}
