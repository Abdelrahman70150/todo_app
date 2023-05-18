import 'package:flutter/material.dart';
import 'package:todo_app/home_layout/home_layout.dart';
import 'package:todo_app/screens/settings_screen.dart';
import 'package:todo_app/screens/tasks_acreen.dart';
import 'package:todo_app/shared/styles/my_theme.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme:myLightTheme,
      darkTheme: myDarkTheme,
      themeMode: ThemeMode.light,
      routes: {
        HomeLayout.routName :(_)=> HomeLayout(),
        SettingsScreen.routName :(_)=> HomeLayout(),
        TasksScreen.routName :(_)=> HomeLayout(),

      },
      initialRoute: HomeLayout.routName,
    );
  }
}
