import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c9/model/user_model.dart';
import 'package:todo_c9/shared/network/firebase/firebase_manager.dart';

import '../shared/network/local/shared_pref/shared_pref.dart';

class MyProvider extends ChangeNotifier{
  UserModel? userModel;
  User? firebaseUser;
  ThemeMode themeMode = ThemeMode.light;

  MyProvider(){
    firebaseUser=FirebaseAuth.instance.currentUser;
    if(firebaseUser !=null ){
      initUser();
    }
  }
  initUser() async {
    firebaseUser=FirebaseAuth.instance.currentUser;
    userModel= await FirebaseManager.readUser(firebaseUser!.uid);

    notifyListeners();
  }
  void init() {
    String  myTheme = SharedPref.getTheme();
    if(myTheme=='dark'){
      enableDarkMode();
    }else{
      enableLightMode();
    }
  }
  void enableDarkMode() {
    themeMode = ThemeMode.dark;
    SharedPref.setTheme('dark');
    notifyListeners();
  }
  void enableLightMode() {
    themeMode = ThemeMode.light;
    SharedPref.setTheme('light');
    notifyListeners();
  }
  bool isDarkEnabled(){
    return themeMode == ThemeMode.dark;
  }
}