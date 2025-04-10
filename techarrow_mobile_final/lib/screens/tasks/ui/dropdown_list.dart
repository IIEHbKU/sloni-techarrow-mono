import 'package:flutter/material.dart';
import 'package:techarrow_mobile_final/screens/tasks/ui/dropdown.dart';
import 'package:techarrow_mobile_final/screens/tasks/ui/task_card_widget.dart';

class DropdownList extends StatefulWidget {
  const DropdownList({super.key, required this.title});
  final String title;

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  @override
  Widget build(BuildContext context) {
    return Dropdown(
        button: TaskCardWidget(
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        controller: ValueNotifier<bool>(false),
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => TaskCardWidget(
                  onTap: () {},
                  onEditTapped: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task ${i + 1}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text("05:00"),
                    ],
                  )),
              separatorBuilder: (context, index) => Divider(),
              itemCount: 3)
        ]);
  }
}
