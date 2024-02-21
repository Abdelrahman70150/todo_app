import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c9/model/user_model.dart';
import 'package:todo_c9/shared/network/firebase/firebase_manager.dart';

class MyProvider extends ChangeNotifier{
  UserModel? userModel;
  User? firebaseUser;
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
}