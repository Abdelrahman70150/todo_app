import 'package:flutter/material.dart';
import 'package:todo_c9/model/task_model.dart';
import 'package:todo_c9/shared/components/dialog.dart';
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
      backgroundColor: mintGreen,
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
                  Text('Edit Task',style:Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 17.5)),
                  const SizedBox(height: 17,),
                  //title
                  TextFormField(
                    maxLines: 1,
                    cursorColor: primary,
                    cursorHeight: 25,
                    style:Theme.of(context).textTheme.titleLarge,
                    controller: title,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: primary,),
                        ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  //description
                  TextFormField(
                    maxLines: 6,
                    cursorColor: primary,
                    cursorHeight: 25,
                    style:Theme.of(context).textTheme.titleLarge,
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
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text('Select Date',style:Theme.of(context).textTheme.displayLarge, textAlign: TextAlign.center),
                  const SizedBox(height: 20,),
                  //date
                  InkWell(
                    onTap: (){
                      selectDate();
                    },
                    child: Text(
                      selectedDate.toString().substring(0,10),
                        style:Theme.of(context).textTheme.displayLarge?.copyWith(color: primary,fontSize: 18),
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: primary,fixedSize: const Size( 300,50)),
                      onPressed: (){
                        TaskModel task = TaskModel(userId: widget.taskModel.userId,
                             title: title.text,
                            description: description.text,
                            id: widget.taskModel.id,
                            isDone: widget.taskModel.isDone,
                            date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
                        FirebaseManager.updateTask(task);
                        DialogUtils.showMessage(context,
                            message: "Task Updated Successfully",
                            title: 'Successfully',
                            isDismissible: false,
                          postActionMessage: 'OK',
                          icon:  Icon(Icons.done_all,color: primary,size: 45,),
                          postAction: (){
                            Navigator.pop(context);
                          }
                        );
                      },
                      child:  Text(
                        'Save Changes',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
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
