import 'package:flutter/material.dart';
import 'package:techarrow_mobile_final/screens/tasks/features.dart';
import 'package:techarrow_mobile_final/screens/tasks/ui/dropdown.dart';
import 'package:techarrow_mobile_final/screens/tasks/ui/task_card_widget.dart';
import 'package:techarrow_mobile_final/utils/task.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final _features = TasksScreenFeatures();
  late final Future<List<Task>> _tasksFuture;
  @override
  void initState() {
    _tasksFuture = _features.getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final data = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Задачи"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              getDropdown(
                  "Запланированные",
                  data
                      .where(
                          (element) => element.status == TaskStatus.scheduled)
                      .toList()),
              SizedBox(
                height: 20,
              ),
              getDropdown(
                  "Незапланированные",
                  data
                      .where(
                          (element) => element.status == TaskStatus.unscheduled)
                      .toList()),
              SizedBox(
                height: 20,
              ),
              getDropdown(
                  "Выполненные",
                  data
                      .where((element) => element.status == TaskStatus.done)
                      .toList()),
            ],
          )),
        );
      },
      future: _tasksFuture,
    );
  }

  Widget getDropdown(String name, List<Task> data) {
    return Dropdown(
        button: TaskCardWidget(
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        controller: ValueNotifier<bool>(false),
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => TaskCardWidget(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[i].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(data[i].description),
                    ],
                  )),
              itemCount: data.length)
        ]);
  }
}
