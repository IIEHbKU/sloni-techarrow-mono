import 'package:flutter/material.dart';
import 'package:flutter_time_duration_picker/flutter_time_duration_picker.dart';

class SubtaskListWidget extends StatefulWidget {
  const SubtaskListWidget({super.key});

  @override
  State<SubtaskListWidget> createState() => _SubtaskListWidgetState();
  static List<String> getSubtasksNames() {
    return _SubtaskListWidgetState.getSubtasksNames();
  }

  static List<Duration> getSubtasksDurations() {
    return _SubtaskListWidgetState.getSubtasksDurations();
  }

  void disposeStaticFields() {
    _SubtaskListWidgetState.disposeStaticFields();
  }
}

class _SubtaskListWidgetState extends State<SubtaskListWidget> {
  static int count = 1;

  static List<TextEditingController> _nameControllers = [
    TextEditingController()
  ];

  static List<TimeColumnController> _daysControllers = [
    TimeColumnController(minValue: 0, maxValue: 30)
  ];

  static List<TimeColumnController> _hoursControllers = [
    TimeColumnController(minValue: 0, maxValue: 23)
  ];

  static List<TimeColumnController> _minutesControllers = [
    TimeColumnController(minValue: 0, maxValue: 59)
  ];

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;

    return Wrap(
      spacing: 20,
      children: List.generate(
        count,
        (int index) => Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Название подзадачи",
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () {
                        if (count == 1) return;
                        setState(
                          () {
                            _nameControllers.removeAt(index);
                            _daysControllers.removeAt(index);
                            _hoursControllers.removeAt(index);
                            _minutesControllers.removeAt(index);
                            count--;
                          },
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: _nameControllers[index],
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Введите название подзадачи"),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Длительность подзадачи:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TimeDurationPicker(
                columns: [
                  TimeColumnConfig.custom(
                      id: "hours",
                      maxValue: 30,
                      controller: _daysControllers[index]),
                  TimeColumnConfig.label(id: "days_label", text: "дней"),
                  TimeColumnConfig.hours(controller: _hoursControllers[index]),
                  TimeColumnConfig.label(id: "hours_label", text: "часов"),
                  TimeColumnConfig.minutes(
                      controller: _minutesControllers[index]),
                  TimeColumnConfig.label(id: "minutes_label", text: "минут"),
                ],
                height: 90,
                columnSpacing: 0.01,
                theme: TimeDurationPickerTheme(
                  selectedTextStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onChanged: (List<int> values) {
                  print('Selected duration: $values');
                },
              ),
            ],
          ),
        ),
      )..add(
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () {
                  setState(
                    () {
                      count++;
                      _nameControllers.add(TextEditingController());
                      _daysControllers
                          .add(TimeColumnController(minValue: 0, maxValue: 30));
                      _hoursControllers
                          .add(TimeColumnController(minValue: 0, maxValue: 23));
                      _minutesControllers
                          .add(TimeColumnController(minValue: 0, maxValue: 59));
                    },
                  );
                },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      size: 36,
                      color: color,
                    ),
                    Text(
                      "Добавить подзадачу",
                      style: TextStyle(
                        fontSize: 18,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  static void disposeStaticFields() {
    count = 1;
    _nameControllers = [TextEditingController()];
    _daysControllers = [TimeColumnController(minValue: 0, maxValue: 30)];
    _hoursControllers = [TimeColumnController(minValue: 0, maxValue: 23)];
    _minutesControllers = [TimeColumnController(minValue: 0, maxValue: 59)];
  }

  static List<String> getSubtasksNames() {
    return _nameControllers.map((e) => e.text).toList();
  }

  static List<Duration> getSubtasksDurations() {
    List<Duration> durations = [];
    Duration duration;

    for (int i = 0; i < _daysControllers.length; i++) {
      duration = Duration(
        days: _daysControllers[i].value,
        hours: _hoursControllers[i].value,
        minutes: _minutesControllers[i].value,
      );
      durations.add(duration);
    }
    return durations;
  }
}
