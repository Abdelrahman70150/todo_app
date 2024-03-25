// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_'
    'slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_c9/model/task_model.dart';
import 'package:todo_c9/providers/my_provider.dart';
import 'package:todo_c9/screens/edit_task/edit_task_screen.dart';
import 'package:todo_c9/shared/network/firebase/firebase_manager.dart';
import 'package:todo_c9/shared/styles/colors.dart';

import '../../shared/styles/theming.dart';

// ignore: must_be_immutable
class TaskItem extends StatelessWidget {
  TaskModel task;
  TaskItem(this.task, {super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5.0,left: 8,right: 8),
      child: SizedBox(
        child: Card(
          color: provider.themeMode == MyThemeData.lightTheme ?Colors.white:bottomNavBarColor,
          elevation: 7,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Slidable(
            startActionPane:  ActionPane(motion: const DrawerMotion(),
                children: [
                  SlidableAction(onPressed: (context){
                    FirebaseManager.deleteTask(task.id);
                  },
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: const BorderRadius.only(topLeft:Radius.circular(20) ,bottomLeft: Radius.circular(20),),
                  ),
                  SlidableAction(
                    onPressed: (context){ 
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context)=>UpdateTask(taskModel: task)));
                    },
                    backgroundColor: provider.themeMode == MyThemeData.lightTheme ?primary:liteBlue,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(7.5),
              child: Row(
                children: [
                  SizedBox(width:MediaQuery.of(context).size.width*0.02),
                  Container(
                    width: 4,
                    height:  MediaQuery.of(context).size.height*0.09,
                    decoration: BoxDecoration(
                        color: task.isDone ? Colors.green : primary,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color:task.isDone ? Colors.green : primary,)),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*0.019,),
                        Text(
                          task.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(color:task.isDone ? Colors.green : provider.themeMode == MyThemeData.lightTheme ?primary:Colors.white,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.026,),
                        Text(
                          task.description,
                          maxLines: 10,
                           overflow: TextOverflow.ellipsis,
                          style:  Theme.of(context).textTheme.titleSmall?.copyWith(color:task.isDone ? Colors.green : Colors.grey,),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.019,),
                      ],
                    ),
                  ),
                   SizedBox(width:MediaQuery.of(context).size.width*0.03),
                //  SizedBox(width: 20,),
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
                      child: task.isDone ?
                      Center(child: Text('Done !',style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green,fontSize: 18),))
                          : const Icon(
                         Icons.check,
                        size: 30  ,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width:MediaQuery.of(context).size.width*0.02),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
