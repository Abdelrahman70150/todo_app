class UserModel{
  String id ;
  String email;
  String name ;

  UserModel({required this.id, required this.email, required this.name});

  UserModel.fromJson(Map<String,dynamic> json):this(
    id: json['id'],
    email: json['email'],
    name:json['name'],
  );
  Map<String,dynamic>toJson(){
    return {
      "id": id,
      "email": email,
      "name":name,
    };
  }
}