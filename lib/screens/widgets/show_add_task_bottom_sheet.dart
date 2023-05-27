import 'package:flutter/material.dart';
import 'package:todo_app/shared/styles/app_colors.dart';

class ShowAddTaskBottomSheet extends StatefulWidget {

  @override
  State<ShowAddTaskBottomSheet> createState() => _ShowAddTaskBottomSheetState();
}

class _ShowAddTaskBottomSheetState extends State<ShowAddTaskBottomSheet> {
var formKey = GlobalKey<FormState>();
var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Add New Task',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 25,
            ),
            //  Task Text Form Field
            TextFormField(
              decoration: InputDecoration(
                hintText: 'enter your task',
                hintStyle: TextStyle(
                    color: const Color(0xffa9a9a9).withOpacity(.4),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your task';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 50,
            ),
            // Select Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select time',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                ),
                IconButton(
                   onPressed: (){
                     chooseDate(context);
                   },
                  icon: Icon(Icons.calendar_month_outlined, color: myBluePrimaryColor,),

                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            // The Time
            Text(
              selectedDate.toString().substring(0,10),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color:Color(0xffa9a9a9).withOpacity(.4),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // elevated bottom
            SizedBox(
              width: MediaQuery.of(context).size.width*.5,
              child: ElevatedButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      print('rout');
                    }
                  }, child: Text(
                'Add Task',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
  void  chooseDate(BuildContext context)async{
  DateTime? chosenDate = await showDatePicker(context: context,
    initialDate: selectedDate,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 3665),
    ),
  );
  if(chosenDate != null){
    selectedDate= chosenDate;
    setState(() {
      print(selectedDate.toString());
    });
  }

}

}

