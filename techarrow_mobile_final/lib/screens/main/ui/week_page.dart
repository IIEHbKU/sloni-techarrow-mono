import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techarrow_mobile_final/screens/main/ui/tetris_page.dart';
import 'package:techarrow_mobile_final/utils/matrix.dart';
import 'package:techarrow_mobile_final/utils/matrixTools.dart';
import 'package:techarrow_mobile_final/utils/task.dart';

List<Color> colors = [Colors.red, Colors.blue, Colors.green];

class WeekPage extends StatefulWidget {
  const WeekPage({super.key});

  @override
  State<WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
  List<Task> tasks = [
    Task(2, "red", "awd", 0, 2, 0),
    Task(3, "green", "awawdawdd", 0, 2, 2),
    Task(4, "blue", "123123123", 0, 2, 1),
    Task(5, "red", "awd", 0, 2, 0),
    Task(6, "green", "awawdawdd", 0, 2, 2),
    Task(7, "blue", "123123123", 0, 2, 1)
  ];

  int rows = 12;
  int columns = 7;
  bool counter = false;
  int index = 0;
  late Task temp;
  Set<int> alreadyFilledLines = {};

  Matrix matrix = Matrix();

  int n = 1;
  Timer? timer;

  bool freezed = false;

  void startTimer(List<Task> curTasks) {
    const int time = 500;

    counter = false;
    index = 0;
    n = 1;
    matrix.matrix = createEmpty(rows, columns);
    matrix.isRepaint = 0;

    timer = Timer.periodic(Duration(milliseconds: time), (timer) {
      setState(() {
        update(timer);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void update(Timer timer) {
    if (!counter) {
      if (index == tasks.length) {
        print("cancel");
        timer.cancel();
      } else {
        temp = tasks[index];
        counter = true;
        index++;

        n += 1;
        addShape(matrix.matrix, temp.len, colors[temp.colorId], n);
      }
    }
    if (freezed) {
      freeze(matrix.matrix, n);
      freezed = false;
      counter = false;
    } else if (!moveDownShape(matrix.matrix, n)) {
      counter = false;
      if (isFilledLine(matrix.matrix, alreadyFilledLines)) {
        Fluttertoast.showToast(
            msg: "совет",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      print("counter $counter");
    }

    matrix.isRepaint++;
  }

  @override
  void initState() {
    matrix.setMatrix(createEmpty(rows, columns));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    Task task;

    matrix.isReadOnly = true;

    return Center(
      child: Column(children: [
        SizedBox(
          height: height * 0.05,
        ),
        SizedBox(
          height: height * 0.5,
          width: width * 0.8,
          child: GestureDetector(
            onTapDown: (details) => {
              if (matrix.numberOnXY(details.localPosition, 0, 0).number != 0)
                {
                  task = tasks[
                      matrix.numberOnXY(details.localPosition, 0, 0).number -
                          2],
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(task.title),
                        content: Text(task.description),
                        actions: matrix.isReadOnly
                            ? <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ]
                            : <Widget>[
                                TextButton(
                                    child: Text('выполнить'),
                                    onPressed: () {
                                      setState(() {
                                        // TODO логика выполнения
                                        deleteNumber(matrix.matrix, task.id);
                                        moveDownAllShapes(matrix.matrix);
                                        matrix.isRepaint++;
                                      });
                                      Navigator.of(context).pop();
                                    }),
                                TextButton(
                                    child: Text('удалить'),
                                    onPressed: () {
                                      setState(() {
                                        deleteNumber(matrix.matrix, task.id);
                                        moveDownAllShapes(matrix.matrix);
                                        matrix.isRepaint++;
                                      });
                                      Navigator.of(context).pop();
                                    }),
                                TextButton(
                                  child: Text('ОК'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                      );
                    },
                  )
                }
            },
            child: CustomPaint(
              key: ValueKey(matrix.isRepaint),
              painter: matrix,
            ),
          ),
        ),
      ]),
    );
  }
}
