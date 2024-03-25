// ignore_for_file: unrelated_type_equality_checks

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c9/providers/my_provider.dart';
import 'package:todo_c9/screens/login/login_screen.dart';
import 'package:todo_c9/screens/settings/settings_tab.dart';
import 'package:todo_c9/screens/tasks/add_task_bottom_sheet.dart';
import 'package:todo_c9/screens/tasks/tasks_tab.dart';
import 'package:todo_c9/shared/styles/colors.dart';
import 'package:todo_c9/shared/styles/theming.dart';

class HomeLayout extends StatefulWidget {
  static const String routName = "homeLayout";

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;
  List<Widget> tabs = [const TasksTab(), const SettingsTab()];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: provider.themeMode == MyThemeData.lightTheme ? mintGreen:darkBlue,
      appBar: AppBar(
        backgroundColor: provider.themeMode == MyThemeData.lightTheme ? mintGreen:liteBlue,
        actions: [
          IconButton(
              onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routName, (route) => false);
          },
              icon: const Icon(Icons.login_outlined,color: Colors.white ,))
        ],
        title:   Text('ToDo ${provider.userModel?.name}'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: provider.themeMode == MyThemeData.lightTheme ? mintGreen:liteBlue,
        shape: const StadiumBorder(
            side: BorderSide(
          color: Colors.white,
          width: 3,
        )),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon(
          Icons.add,color: Colors.white
          ,),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 66,// padding: EdgeInsets.only(bottom:2),
        notchMargin: 8,
        color: provider.themeMode == MyThemeData.lightTheme ? mintGreen:bottomNavBarColor,
        shape: const CircularNotchedRectangle(),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
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
        child:  AddTaskBottomSheet(),
      );
    });
  }
}
