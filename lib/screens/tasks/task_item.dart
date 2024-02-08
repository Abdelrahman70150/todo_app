import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_c9/model/task_model.dart';
import 'package:todo_c9/shared/network/firebase/firebase_manager.dart';
import 'package:todo_c9/shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;
  TaskItem(this.task, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0,left: 8,right: 8),
      child: Container(
        height: 115,
        child: Card(
          elevation: 7,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Slidable(
            startActionPane:  ActionPane(motion: DrawerMotion(),
                children: [
                  SlidableAction(onPressed: (context){
                    FirebaseManager.deleteTask(task.id);
                  },
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(20) ,bottomLeft: Radius.circular(20),),
                  ),
                  SlidableAction(onPressed: (context){},
                    backgroundColor: Colors.blue,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(7.5),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Container(
                    width: 4,
                    height: 62,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.blue)),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        task.description,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      task.isDone=true;
                      FirebaseManager.updateTask(task);
                    },
                    child: Container(
                      height: 34,width: 69,
                      decoration: BoxDecoration(
                        color: task.isDone ? Colors.transparent: primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: task.isDone ? Center(child: Text('Done !',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 17),))
                          : Icon(
                         Icons.check,
                        size: 30  ,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
