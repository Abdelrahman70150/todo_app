import 'package:flutter/material.dart';
import 'package:todo_c9/shared/styles/colors.dart';

class MyThemeData{

  static ThemeData lightTheme =ThemeData(
    brightness: Brightness.light,
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedItemColor:primary,
      type:BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
    ),
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme:  AppBarTheme(
      color: primary,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22
      )
    ),

  );


  static ThemeData darkTheme =ThemeData();


}