import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techarrow_mobile_final/screens/pomodoro/features.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class PomodoroScreenArguments {
  final String taskName;
  final String taskId;

  PomodoroScreenArguments({required this.taskName, required this.taskId});
}

class _PomodoroScreenState extends State<PomodoroScreen>
    with SingleTickerProviderStateMixin {
  int cycle = 1;
  int timer = 25 * 60;
  int timerMinutes = 25;
  late final Timer _timer;

  final _features = PomodoroScreenFeatures();
  bool _isRunning = false;

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  late AnimationController _controller;
  late Animation<Color?> animation;

  resetTimer() {
    final prev = timerMinutes;

    setState(() {
      cycle = 1;
      timer = 25 * 60;
      timerMinutes = 25;
      _isRunning = false;
    });
    animation =
        ColorTween(begin: _features.getColor(prev), end: _features.getColor(25))
            .animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    _controller.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    animation = ColorTween(
            begin: _features.getColor(timerMinutes),
            end: _features.getColor(timerMinutes))
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _timer = Timer.periodic(const Duration(milliseconds: 10), (val) {
      if (!_isRunning) return;
      final prev = timerMinutes;
      if (timer == 0) {
        setState(() {
          timer--;
          cycle++;
          timerMinutes = _features.getNextTimerMinutes(context, val, cycle);
          timer = timerMinutes * 60;
          _isRunning = false;
        });
        animation = ColorTween(
                begin: _features.getColor(prev),
                end: _features.getColor(timerMinutes))
            .animate(_controller)
          ..addListener(() {
            setState(() {});
          });

        _controller.forward(from: 0);
        return;
      }
      setState(() {
        timer--;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PomodoroScreenArguments;
    final taskName = args.taskName;
    final taskId = args.taskId;
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: (animation.value ?? Colors.white).withAlpha(240),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: (animation.value ?? Colors.white).withAlpha(230),
              title: Text(
                taskName,
                style: const TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Column(children: [
                const Spacer(
                  flex: 3,
                ),
                Text(_features.formatDuration(Duration(seconds: timer)),
                    style: const TextStyle(color: Colors.white, fontSize: 50)),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isRunning = !_isRunning;
                      });
                    },
                    style: ButtonStyle(
                      shape: const WidgetStatePropertyAll(CircleBorder()),
                      padding:
                          const WidgetStatePropertyAll(EdgeInsets.all(100)),
                      backgroundColor: WidgetStatePropertyAll(
                          animation.value ?? Colors.white), // <-- Button color
                    ),
                    child: Text(_isRunning ? "Пауза" : "Старт",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 50))),
                const Spacer(flex: 5),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            resetTimer();
                          },
                          style: ButtonStyle(
                            shape: const WidgetStatePropertyAll(CircleBorder()),
                            padding: const WidgetStatePropertyAll(
                                EdgeInsets.all(20)),
                            backgroundColor: WidgetStatePropertyAll(
                                animation.value ??
                                    Colors.white), // <-- Button color
                          ),
                          child: const Icon(
                            Icons.restart_alt,
                            color: Colors.white,
                          )),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (taskId != "") {
                                _features.markTaskAsCompleted(taskId).then((v) {
                                  if (context.mounted) {
                                    Fluttertoast.showToast(msg: "Успешно!");
                                    Navigator.of(context).pop();
                                  }
                                });
                                return;
                              }
                              Navigator.of(context).pop();
                            });
                          },
                          style: ButtonStyle(
                            shape: const WidgetStatePropertyAll(CircleBorder()),
                            padding: const WidgetStatePropertyAll(
                                EdgeInsets.all(20)),
                            backgroundColor: WidgetStatePropertyAll(
                                animation.value ??
                                    Colors.white), // <-- Button color
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          )),
                      const Spacer(),
                    ],
                  ),
                ),
              ])),
            ),
          );
        });
  }
}
