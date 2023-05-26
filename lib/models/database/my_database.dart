import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/database/database_model.dart';


class MyDataBase{
  static CollectionReference <User> getUserCollection(){
    return FirebaseFirestore.instance.collection('users')
        .withConverter(
      fromFirestore:
      User.fromFireStore,
      toFirestore :(user , options)=>user.toFireStore(),
    );
}

  static Future<void>addUser(User user){
    var collection = getUserCollection();
    return collection.doc(user.id).set(user);
  }
}