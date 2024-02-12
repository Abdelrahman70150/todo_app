import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c9/model/task_model.dart';

class FirebaseManager{
 static CollectionReference<TaskModel> getTasksCollection(){

 return  FirebaseFirestore.instance.collection("Tasks")
        .withConverter<TaskModel>(
        fromFirestore: (snapshot, _) {
          return TaskModel.fromJson(snapshot.data()!);
        },
        toFirestore: (task, _) {
          return task.toJson();
        },
    );
}
  static  Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
   return docRef.set(task);
  }
  static Stream<QuerySnapshot<TaskModel>> getTask (DateTime date){
   return getTasksCollection().where('date',isEqualTo:DateUtils.dateOnly(date).millisecondsSinceEpoch).snapshots();
  }
  static Future<void> deleteTask(String taskId){
  return getTasksCollection().doc(taskId).delete();
  }
  static Future<void> updateTask (TaskModel task){
  return getTasksCollection().doc(task.id).update(task.toJson());
  }
 static Future<void> createAccount(String email, String password,
     {required Function onSuccess,required Function onError})async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      print(e);
    }
  }
 static Future<void> login(String email,String password)async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      print('Wrong E-Mail and Password');
    }
  }
}