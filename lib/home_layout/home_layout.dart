import 'package:flutter/material.dart';
import 'package:todo_app/screens/settings_screen.dart';
import 'package:todo_app/screens/tasks_acreen.dart';
import 'package:todo_app/screens/widgets/show_add_task_bottom_sheet.dart';
import 'package:todo_app/shared/styles/app_colors.dart';

class HomeLayout extends StatefulWidget {
static const String routName ='homeLayout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
int currentIndex=0;
List<Widget> screens =[
  TasksScreen(),
  SettingsScreen(),
];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Container(
          height: 98,
          margin: EdgeInsets.only(left: 25),
          child: Text(
            'To Do List',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: BorderSide(
              color: Colors.white,
              width: 3,
            )
        ),
        onPressed: (){
          showAppTaskBottomSheet();
        },
        backgroundColor: myBluePrimaryColor,
        child: Icon(
          Icons.add,
          size: 30,

        ),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex:currentIndex ,
          onTap: (index){
            currentIndex=index;
            setState(() {

            });
          },
          items: [

            BottomNavigationBarItem(icon: Icon(
              Icons.list,
              size: 30,
            ),
            label: ''),
            BottomNavigationBarItem(icon: Icon(
              Icons.settings,
              size: 30,
            ),
                label: '')
          ],
        ),
      ),

      body:screens[currentIndex],
    );
  }
  void showAppTaskBottomSheet(){
    showModalBottomSheet(context: context, builder: (context)=>
        Padding(
          padding:  EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,

          ),
          child: ShowAddTaskBottomSheet( ),
        ),
    isScrollControlled: true,

    );
  }
}
