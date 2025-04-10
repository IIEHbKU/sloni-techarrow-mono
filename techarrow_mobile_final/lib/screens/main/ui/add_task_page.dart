import 'package:flutter/material.dart';
import 'package:flutter_time_duration_picker/flutter_time_duration_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techarrow_mobile_final/enums/task_types.dart';
import 'package:techarrow_mobile_final/screens/task_creation/ui/subtask_list_widget.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  final TimeColumnController _daysController =
      TimeColumnController(minValue: 0, maxValue: 30);
  final TimeColumnController _hoursController =
      TimeColumnController(minValue: 0, maxValue: 23);
  final TimeColumnController _minutesController =
      TimeColumnController(minValue: 0, maxValue: 59);

  List<DropdownMenuItem<TaskTypes>> get dropdownItems {
    List<DropdownMenuItem<TaskTypes>> menuItems = [
      DropdownMenuItem(value: TaskTypes.learning, child: Text("Учёба")),
      DropdownMenuItem(value: TaskTypes.work, child: Text("Работа")),
      DropdownMenuItem(value: TaskTypes.personal, child: Text("Личные дела")),
    ];
    return menuItems;
  }

  TaskTypes selectedValue = TaskTypes.learning;
  bool isImportant = false;
  bool isLarge = false;

  final SubtaskListWidget subtasklist = SubtaskListWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Добавить задачу"),
          centerTitle: true,
          forceMaterialTransparency: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 20,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Название задачи",
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  TextField(
                    controller: _taskNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Введите название задачи"),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Описание задачи",
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  TextFormField(
                    controller: _taskDescriptionController,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Описание задачи"),
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 19),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Выберите категорию задачи:",
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: DropdownButton(
                      items: dropdownItems,
                      value: selectedValue,
                      style: TextStyle(color: Colors.black, fontSize: 19),
                      padding: EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: Theme.of(context).cardColor,
                      underline: SizedBox(),
                      alignment: Alignment.center,
                      isExpanded: true,
                      onChanged: (TaskTypes? newValue) {
                        setState(
                          () {
                            selectedValue = newValue!;
                          },
                        );
                      },
                    ),
                  ),
                  !isLarge
                      ? SizedBox(
                          height: 30,
                        )
                      : SizedBox(
                          height: 5,
                        ),
                  !isLarge
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Длительность задачи:",
                            style: TextStyle(
                              fontSize: 21,
                            ),
                          ),
                        )
                      : SizedBox(),
                  !isLarge
                      ? TimeDurationPicker(
                          columns: [
                            TimeColumnConfig.custom(
                                id: "hours",
                                maxValue: 30,
                                controller: _daysController),
                            TimeColumnConfig.label(
                                id: "days_label", text: "дней"),
                            TimeColumnConfig.hours(
                                controller: _hoursController),
                            TimeColumnConfig.label(
                                id: "hours_label", text: "часов"),
                            TimeColumnConfig.minutes(
                                controller: _minutesController),
                            TimeColumnConfig.label(
                                id: "minutes_label", text: "минут"),
                          ],
                          height: 90,
                          columnSpacing: 0.01,
                          theme: TimeDurationPickerTheme(
                            selectedTextStyle: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                          onChanged: (List<int> values) {
                            print('Selected duration: $values');
                          },
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isImportant = !isImportant;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: isImportant,
                          onChanged: (bool? value) {
                            setState(
                              () {
                                isImportant = value!;
                              },
                            );
                          },
                        ),
                        Text(
                          "Особо важная задача",
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLarge = !isLarge;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: isLarge,
                          onChanged: (bool? value) {
                            setState(
                              () {
                                isLarge = value!;
                              },
                            );
                          },
                        ),
                        Text(
                          "Большая задача",
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        )
                      ],
                    ),
                  ),
                  isLarge ? subtasklist : SizedBox(),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
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
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: "Запланировать задачу можно в боковом меню!");
                      },
                      child: Text(
                        "Создать задачу!",
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    subtasklist.disposeStaticFields();
    super.dispose();
  }
}
