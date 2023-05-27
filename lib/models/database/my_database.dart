import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/database/task_model.dart';
import 'package:todo_app/models/database/user_model.dart';


class FirebaseFunctions{
  static CollectionReference <UserModel> getUserCollection(){
    return FirebaseFirestore.instance.collection(UserModel.collectionName)
        .withConverter<UserModel>(
      fromFirestore:
      UserModel.fromFireStore,
      toFirestore :(userModel , options)=>userModel.toFireStore(),
    );
}

  static Future<void>addUser(UserModel user){
    var collection = getUserCollection();
    return collection.doc(user.id).set(user);
  }


 static CollectionReference <TaskModel> getTaskCollection(String uid){
    return getUserCollection().doc(uid).collection(TaskModel.collectionName)
        .withConverter<TaskModel>(fromFirestore: (snapshot, options) => TaskModel.fromFireStore(snapshot, options),
        toFirestore: (TaskModel task, options) => task.toFirestore()
    );
 }
}