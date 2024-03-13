
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_c9/model/task_model.dart';
import 'package:todo_c9/screens/tasks/task_item.dart';
import 'package:todo_c9/shared/network/firebase/firebase_manager.dart';
import 'package:todo_c9/shared/styles/colors.dart';

class TasksTab extends StatefulWidget {
  static const String routName="tasksTab";

  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(color: primary,height: 70 ,),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CalendarTimeline(
                initialDate:selectedDate,
                firstDate: DateTime.now().subtract(const Duration(days: 10)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date){
                  selectedDate=date;
                  setState(() {
                  });
                },
                leftMargin: 10,
                monthColor: Colors.white,
                dayColor: Colors.grey,
                activeDayColor: primary,
                activeBackgroundDayColor:  Colors.white,
                dotsColor:primary,
                selectableDayPredicate: (date) => true,
                locale: 'en_ISO',
              ),
            ),

          ],
        ),
        //Container(color: primary,height: 40,),
        // CalendarTimeline(
        //   initialDate:selectedDate,
        //   firstDate: DateTime.now().subtract(const Duration(days: 10)),
        //   lastDate: DateTime.now().add(const Duration(days: 365)),
        //   onDateSelected: (date){
        //     selectedDate=date;
        //     setState(() {
        //     });
        //   },
        //   leftMargin: 20,
        //   monthColor: primary,
        //   dayColor: Colors.grey,
        //   activeDayColor: Colors.white,
        //   activeBackgroundDayColor: primary,
        //   dotsColor:Colors.white,
        //   selectableDayPredicate: (date) => true,
        //   locale: 'en_ISO',
        // ),
        const SizedBox(height: 10,),
        Expanded(
          child:StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseManager.getTask(selectedDate),
          builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return const Center(child: Text('SomeThing Went Wrong'));
              }
              List<TaskModel> tasks = snapshot.data?.docs.map((doc) => doc.data()).toList()??[];
              return ListView.builder(itemBuilder: (context, index) => TaskItem(tasks[index]),itemCount: tasks.length,);
          },
          )

        )
      ],

    );

  }
}
