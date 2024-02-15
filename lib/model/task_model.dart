class TaskModel{
  String id;
  String title;
  String description;
  int date;
  bool isDone;
  String userId;
  TaskModel({this.id='',required this.userId, required this.title, required this.description, this.isDone=false, required this.date});

  TaskModel.fromJson(Map<String,dynamic> data)
    : this(
    id : data['id'],
    userId : data['userId'],
    title : data['title'],
    description : data['description'],
    date : data['date'],
    isDone : data['isDone'],
    ) ;

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'userId':userId,
      'title':title,
      'description':description,
      'date':date,
      'isDone': isDone,
    };
  }

}