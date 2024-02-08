import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_c9/firebase_options.dart';
import 'package:todo_c9/layout/home_layout.dart';
import 'package:todo_c9/screens/login/login_screen.dart';
import 'package:todo_c9/screens/register/register_screen.dart';
import 'package:todo_c9/screens/settings/settings_tab.dart';
import 'package:todo_c9/screens/tasks/tasks_tab.dart';
import 'package:todo_c9/shared/styles/theming.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.disableNetwork();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoApp',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routName,
      routes: {
        HomeLayout.routName :(context)=>HomeLayout(),
        SettingsTab.routName :(context)=>SettingsTab(),
        TasksTab.routName:(context)=>TasksTab(),
        LoginScreen.routName :(context)=>LoginScreen(),
        RegisterScreen.routName :(context)=>RegisterScreen(),


      },
      theme: MyThemeData.lightTheme,
      themeMode: ThemeMode.light,

    );
  }
}


