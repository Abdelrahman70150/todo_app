import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/styles/app_colors.dart';

class TasksScreen extends StatelessWidget {
  static const String routName ='homeLayout';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: DatePicker(
        height: 105,
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectionColor:myBluePrimaryColor,
        onDateChange: (date) {
          // New date selected

        },
      ),
    );
  }
}