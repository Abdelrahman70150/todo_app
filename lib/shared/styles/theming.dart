import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_c9/shared/styles/colors.dart';

class MyThemeData{

  static ThemeData lightTheme =ThemeData(
    textTheme: TextTheme(
      bodySmall: GoogleFonts.poppins(fontSize: 21,fontWeight: FontWeight.bold),
      displayLarge: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold),
     // bodyMedium: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold),//add task sheet title, select date text, edit task title
     titleLarge: GoogleFonts.poppins(fontSize: 17.5,fontWeight: FontWeight.w600,),
      displayMedium: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),//select date text
      titleSmall: GoogleFonts.poppins(fontSize: 14.5,fontWeight: FontWeight.normal),//task description
      titleMedium:GoogleFonts.acme(fontSize: 14, fontWeight: FontWeight.bold), //task and description text field hint
    ),
    primaryColor: primary,
    brightness: Brightness.light,
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedItemColor:primary,
      type:BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
    ),
    scaffoldBackgroundColor:Colors.transparent,
    appBarTheme:  AppBarTheme(
      color: primary,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22
      )
    ),

  );


  static ThemeData darkTheme =ThemeData();


}