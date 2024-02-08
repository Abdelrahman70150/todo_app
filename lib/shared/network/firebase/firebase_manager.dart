import 'package:cloud_firestore/cloud_firestore.dart';
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
}