import 'package:flutter/material.dart';
import 'package:todo_c9/screens/settings/settings_tab.dart';
import 'package:todo_c9/screens/tasks/add_task_bottom_sheet.dart';
import 'package:todo_c9/screens/tasks/tasks_tab.dart';
import 'package:todo_c9/shared/styles/colors.dart';

class HomeLayout extends StatefulWidget {
  static const String routName = "homeLayout";

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;
  List<Widget> tabs = [TasksTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: mintGreen,
      appBar: AppBar(
        centerTitle: true  ,
        title: const Text('ToDo'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        shape: const StadiumBorder(
            side: BorderSide(
          color: Colors.white,
          width: 3,
        )),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon(Icons.add,color: Colors.white
          ,),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 66,// padding: EdgeInsets.only(bottom:2),
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Center(
            child: BottomNavigationBar(
              showSelectedLabels: false,
              elevation: 0,
              iconSize: 25,
              backgroundColor: Colors.transparent,
              items:  const [
                BottomNavigationBarItem(icon: Icon(Icons.list), label: '',),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: '',),
              ],
              currentIndex: index,
              onTap: (value) {
                index = value;
                setState(() {});
              },
            ),
          ),
        ),
      ),
      body: tabs[index],
    );
  }
  showAddTaskBottomSheet(){
    showModalBottomSheet(
      isScrollControlled: true  ,
        context: context, builder: (context){
      return Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AddTaskBottomSheet(),
      );
    });
  }
}
