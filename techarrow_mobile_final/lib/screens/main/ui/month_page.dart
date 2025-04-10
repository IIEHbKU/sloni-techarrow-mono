import 'dart:math';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:techarrow_mobile_final/api/api_service.dart';
import 'package:techarrow_mobile_final/screens/main/ui/tetris_page.dart';
import 'package:techarrow_mobile_final/swagger_generated_api/swagger.swagger.dart';
import 'package:techarrow_mobile_final/utils/task.dart';

class MonthPage extends StatefulWidget {
  const MonthPage({super.key, required this.isCalendarOpened});

  final bool Function() isCalendarOpened;

  @override
  State<MonthPage> createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  bool flag = false;

  final List<String> months = [
    'янв',
    'фев',
    'мар',
    'апр',
    'май',
    'июн',
    'июл',
    'авг',
    'сен',
    'окт',
    'ноя',
    'дек'
  ];
  final List<String> weekdays = ['пн', ' вт', ' ср', 'чт', ' пт', ' сб', ' вс'];

  Future<Response<TaskListRs>?> tasks =
      Future.delayed(const Duration(days: 1), () => null);

  static DateTime _focusedDay = DateTime.now().add(Duration(days: 1));
  static DateTime _selectedDay = DateTime.now();
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  Future<Response<TaskListDateRs>>? _future;
  Future<List<Task>>? _future2;

  void fetch() {
    setState(() {
      _future = ApiService.api.apiTasksGetDataGet(
          data: DateFormat("yyyy.MM.dd").format(_selectedDay));
      _future2 = ApiService.getUnplannedTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    fetch();
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              locale: "ru_RU",
              focusedDay: _focusedDay,
              currentDay: _selectedDay,
              onHeaderTapped: (focusedDay) {
                setState(() {
                  _selectedDay = DateTime.now();
                  _focusedDay = DateTime.now();
                });
              },
              firstDay: DateTime.fromMillisecondsSinceEpoch(0),
              lastDay: DateTime.fromMillisecondsSinceEpoch(2641031200000),
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarFormat: _calendarFormat,
              availableCalendarFormats: const {CalendarFormat.month: ""},
              onDaySelected: (selectedDay, focusedDay) {
                fetch();
                setState(() {
                  _focusedDay = focusedDay;
                  _selectedDay = selectedDay;
                });
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (day.day == DateTime.now().day &&
                      day.month == DateTime.now().month &&
                      day.year == DateTime.now().year) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "${_selectedDay.day} ${months[_selectedDay.month - 1]}, ${weekdays[_selectedDay.weekday - 1]}"
                  .toUpperCase(),
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]
            ..add(FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  print(snapshot.error);
                  if (snapshot.hasData) {
                    if (snapshot.data?.body == null) {
                      return Container();
                    }
                    var data = snapshot.data!.body!;
                    var planned = data.plannedTasks;
                    var completed = data.completedTasks;
                    var tasks = [...planned, ...completed];
                    return Column(
                      children: List.generate(
                        widget.isCalendarOpened() ? tasks.length : 3,
                        (int index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            leading: Checkbox(
                              value: index >= planned.length,
                              onChanged: (value) {},
                            ),
                            title: Text(
                              tasks[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ).toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }))
            ..add(
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  bottom: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (DateTime.now()
                          .isAfter(_focusedDay.add(Duration(days: 1)))) {
                        Fluttertoast.showToast(
                            msg: "Выберите корректную дату!");
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (context) => _taskSelectDialog(context));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          size: 32,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          "Добавить задачи на ${_selectedDay.day} ${months[_selectedDay.month - 1]}",
                          style: TextStyle(
                            fontSize: 19,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }

  AlertDialog _taskSelectDialog(BuildContext context) {
    List? tasks;
    List? checks;

    return AlertDialog(
      title: Text(
        "Новые задачи на ${_selectedDay.day.toString().padLeft(2, "0")}.${(_selectedDay.month).toString().padLeft(2, "0")}.${_selectedDay.year}",
        style: TextStyle(
          fontSize: 22,
        ),
        textAlign: TextAlign.center,
      ),
      content: FutureBuilder(
          future: _future2,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              tasks = snapshot.data!;
              checks = List.generate(tasks!.length, (index) => false);
              return StatefulBuilder(builder: (context, setState) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 5 * 4,
                  height: min(tasks!.length * 60,
                      MediaQuery.of(context).size.height / 5 * 3),
                  child: ListView.builder(
                    itemCount: tasks!.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      onTap: () {
                        setState(() {
                          checks![index] = !checks![index];
                        });
                      },
                      leading: Checkbox(
                        key: ValueKey(tasks![index].id),
                        value: checks![index],
                        onChanged: (value) {
                          setState(() {
                            checks![index] = !checks![index];
                          });
                        },
                      ),
                      title: Text(
                        tasks![index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              });
            }
            return Center(child: CircularProgressIndicator());
          }),
      actionsPadding: EdgeInsets.only(
        bottom: 10,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 5 * 3,
          child: OutlinedButton(
            onPressed: () {
              if (tasks == null || (tasks?.isEmpty ?? false)) return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TetrisPage(
                      start: 8,
                      end: 20,
                      rows: 10,
                      tasks: tasks!
                          .where((e) => checks![tasks!.indexOf(e)])
                          .toList() as List<Task>,
                      mode: 0,
                      date: _selectedDay),
                ),
              );
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: Text(
              "OK",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}
