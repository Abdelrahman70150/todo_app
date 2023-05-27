import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  static const String collectionName = 'tasks';
  String? title;
  String? id;
  String? desc;
  bool? isDone;
  DateTime? dateTime;

  TaskModel({
    required this.title,
    required this.id,
    required this.desc,
    this.isDone= false,
    required this.dateTime
  });

   factory TaskModel.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options){
    final data = snapshot.data();
    return TaskModel(
        id :data?['id'],
        desc : data?["desc"],
        isDone : data?["isDone"],
        title : data?["title"],
        dateTime : DateTime.fromMillisecondsSinceEpoch(data?["date"]));
    }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (title != null) "title": title,
      if (desc != null) "desc": desc,
      if (isDone != null) "isDone": isDone,
      if (dateTime != null) "date": dateTime?.millisecondsSinceEpoch,
    };
  }

}
