import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/shared/styles/app_colors.dart';


ThemeData myLightTheme = ThemeData(
    primaryColor: myBluePrimaryColor,
    scaffoldBackgroundColor:myLightGreenColor,
    textTheme: TextTheme(
        bodyLarge:GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),//22-->20 size
        bodyMedium: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ), // 18 size
        bodySmall: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),// <18 size
    ),
        appBarTheme: AppBarTheme(
                color: myBluePrimaryColor,
                toolbarHeight: 157,
                elevation: 0.0
        )
);

ThemeData myDarkTheme = ThemeData(
);