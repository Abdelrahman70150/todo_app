import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_c9/model/task_model.dart';
import 'package:todo_c9/shared/network/firebase/firebase_manager.dart';
import 'package:todo_c9/shared/styles/colors.dart';

class UpdateTask extends StatefulWidget {
 final TaskModel taskModel;


   const UpdateTask({Key? key,required this.taskModel}) : super(key: key);
  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
 late DateTime selectedDate;
  var title = TextEditingController();
  var description = TextEditingController();
  @override
  void initState() {
    super.initState();
    title.text=widget.taskModel.title;
    description.text=widget.taskModel.description;
    selectedDate=DateTime.fromMillisecondsSinceEpoch(widget.taskModel.date);
  }
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
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(18)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Edit Task',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 7,),
                  TextFormField(
                    maxLines: 1,
                    style: GoogleFonts.acme(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                    controller: title,
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
                    controller: description,
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
                  const SizedBox(height: 20,),
                  Text('Select Date',style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ), textAlign: TextAlign.center),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      selectDate();
                    },
                    child: Text(
                      selectedDate.toString().substring(0,10),style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: primary,
                    ), textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: primary,fixedSize: const Size( 250,50)),
                      onPressed: (){
                        TaskModel task = TaskModel(userId: widget.taskModel.userId,
                             title: title.text,
                            description: description.text,
                            id: widget.taskModel.id,
                            isDone: widget.taskModel.isDone,
                            date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
                        FirebaseManager.updateTask(task);
                        showDialog(context: context,
                          builder: (context) {
                            return  AlertDialog(
                              title: const Text('Successfully'),
                              content: const Text("Task Updated0 Successfully"),
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
                        'Save Changes',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              
              ),
            ),
            ),
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
    selectedDate=DateUtils.dateOnly(chosenDate);
    setState(() {
    });
  }
}
