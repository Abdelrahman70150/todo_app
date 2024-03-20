import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c9/model/task_model.dart';
import 'package:todo_c9/shared/components/dialog.dart';
import 'package:todo_c9/shared/network/firebase/firebase_manager.dart';
import 'package:todo_c9/shared/styles/colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
var titleController = TextEditingController();

var taskDescriptionController = TextEditingController();
DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add New Task',style:Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center),
          const SizedBox(height: 7,),
          //task field
          TextFormField(
            cursorColor: primary,
            cursorHeight: 25,
            maxLines: 1,
            style:Theme.of(context).textTheme.titleLarge,
            controller: titleController,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primary,),
                ),
              hintText:
                'Enter Your Task',
              hintStyle:Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 10,),
          //description
          TextFormField(
            maxLines: 6,
            cursorColor: primary,
            cursorHeight: 25,
            style: Theme.of(context).textTheme.titleLarge,
            controller: taskDescriptionController,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: primary,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,

                ),

              ),
                hintText:
                'Task Description',
                hintStyle:Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 10,),
          Text('Select Date',
              style: Theme.of(context).textTheme.displayLarge, textAlign: TextAlign.center),
          const SizedBox(height: 10,),
          InkWell(
            onTap: (){
              selectDate();
            },
            child: Text(selectedDate.toString().substring(0,10),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(color: primary,fontSize: 18),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primary),
              onPressed: (){
                TaskModel task = TaskModel(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    title: titleController.text,
                    description: taskDescriptionController.text,
                    date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
                FirebaseManager.addTask(task);
                DialogUtils.showMessage(
                    context,
                    message: "Task Added Successfully",
                    title: 'Successfully',
                    isDismissible: false,
                  postActionMessage:'OK' ,
                  postAction: (){
                    Navigator.pop(context);
                    },
                  icon: Icon(Icons.done_all,color: primary,size: 45,),
                );
              },
              child:  Text(
                'Add Task',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

selectDate() async{
    DateTime? chosenDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: primary, // <-- SEE HERE
                onPrimary:Colors.white, // <-- SEE HERE
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: primary, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
    context: context,
    initialDate: selectedDate, firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)));
    if(chosenDate==null){
      return ;
    }
    selectedDate=chosenDate;
    setState(() {
    });
}
}
