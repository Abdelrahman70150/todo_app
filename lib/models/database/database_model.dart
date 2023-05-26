import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String? id;
  String? email;
  String? name;
User({this.id, this.name, this.email});

User.fromFireStore(DocumentSnapshot <Map<String, dynamic>> snapshot,
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