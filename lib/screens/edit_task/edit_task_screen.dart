import 'package:flutter/material.dart';
import 'package:todo_c9/model/task_model.dart';
import 'package:todo_c9/shared/styles/colors.dart';

class UpdateTask extends StatefulWidget {
 final TaskModel taskModel;

  const UpdateTask({Key? key,required this.taskModel}) : super(key: key);
  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To Do List',
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
      ),
      body:Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(color: primary,height: 70,),
          Container(height: MediaQuery.of(context).size.height-200,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(18)),
            ),
        ],
      ),
    );
  }
}
