class TaskModel{
  String id;
  String title;
  String description;
  int date;
  bool isDone;
  TaskModel({this.id='', required this.title, required this.description, this.isDone=false, required this.date});

  TaskModel.fromJson(Map<String,dynamic> data)
    : this(
    id : data['id'],
    title : data['title'],
    description : data['description'],
    date : data['date'],
    isDone : data['isDone'],
    ) ;

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'description':description,
      'date':date,
      'isDone': isDone,
    };
  }

}