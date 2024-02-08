import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_c9/model/task_model.dart';
import 'package:todo_c9/shared/network/firebase/firebase_manager.dart';
import 'package:todo_c9/shared/styles/colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
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
          Text('Add New Task',style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,),
          textAlign: TextAlign.center),
          SizedBox(height: 7,),
          TextFormField(
            maxLines: 1,
            style: GoogleFonts.acme(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
            controller: titleController,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primary,),
                ),
              hintText:
                'Enter Your Task',
              hintStyle: GoogleFonts.acme(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.grey
              )
            ),
          ),
          SizedBox(height: 10,),
          TextFormField(
            maxLines: 6,
            style: GoogleFonts.acme(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            controller: taskDescriptionController,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: primary,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,

                ),

              ),
                hintText:
                'Task Description',
                hintStyle: GoogleFonts.acme(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey
                )
            ),
          ),
          SizedBox(height: 10,),
          Text('Select Date',style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 17
          ), textAlign: TextAlign.center),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              selectDate();
            },
            child: Text(selectedDate.toString().substring(0,10),style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              color: primary,
            ), textAlign: TextAlign.center),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){
                print(selectedDate);
                TaskModel task = TaskModel(title: titleController.text,
                    description: taskDescriptionController.text,
                    date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
                FirebaseManager.addTask(task);
               showDialog(context: context,
                  builder: (context) {
                    return  AlertDialog(
                      title: Text('Successfully'),
                      content: Text("Task Added Successfully"),
                      actions: [
                        ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text(
                                'OK'
                            ))
                      ],
                    );
                  },);
              },
              child: Text(
                'Add Task'
              ))
        ],
      ),
    );
  }

selectDate() async{
    DateTime? chosenDate = await showDatePicker(
    context: context,
    initialDate: selectedDate, firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 365)));
    if(chosenDate==null){
      return ;
    }
    selectedDate=chosenDate;
    setState(() {
    });
}
}