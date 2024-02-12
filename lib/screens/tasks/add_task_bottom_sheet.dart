import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_c9/model/task_model.dart';
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
          Text('Add New Task',style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,),
          textAlign: TextAlign.center),
          const SizedBox(height: 7,),
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
          const SizedBox(height: 10,),
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
              enabledBorder: const UnderlineInputBorder(
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
          const SizedBox(height: 10,),
          Text('Select Date',style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 17
          ), textAlign: TextAlign.center),
          const SizedBox(height: 10,),
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
          const SizedBox(height: 10,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primary),
              onPressed: (){
                TaskModel task = TaskModel(title: titleController.text,
                    description: taskDescriptionController.text,
                    date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
                FirebaseManager.addTask(task);
               showDialog(context: context,
                  builder: (context) {
                    return  AlertDialog(
                      title: const Text('Successfully'),
                      content: const Text("Task Added Successfully"),
                      actions: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: primary),
                            onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text(
                                'OK',style: TextStyle(color: Colors.white),
                            ))
                      ],
                    );
                  },);
              },
              child: const Text(
                'Add Task',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

selectDate() async{
    DateTime? chosenDate = await showDatePicker(
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
