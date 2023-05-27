import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  static const String collectionName = 'user';

  String? id;
  String? email;
  String? name;
UserModel({this.id, this.name, this.email});

UserModel.fromFireStore(DocumentSnapshot <Map<String, dynamic>> snapshot,
    SnapshotOptions? options,){
  final data = snapshot.data();
  id=data?['id'];
  name=data?['name'];
  email=data?['email'];
}
Map<String, dynamic> toFireStore(){
  return{
   if(id!=null ) 'id':id,
    if(name!=null ) 'name':name,
    if(email !=null )'email':email,
  };
}
}