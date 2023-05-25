import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/home_layout/home_layout.dart';
import 'package:todo_app/screens/register_screen/register_screen.dart';
import 'package:todo_app/screens/settings_screen/settings_screen.dart';
import 'package:todo_app/screens/tasks_screen/tasks_acreen.dart';
import 'package:todo_app/shared/styles/my_theme.dart';

import 'screens/login_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
        LoginScreen.routName :(_)=> LoginScreen(),
        RegisterScreen.routName:(_)=> RegisterScreen(),

      },
      initialRoute: LoginScreen.routName,
    );
  }
}
