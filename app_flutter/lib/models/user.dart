class UserModel{
  final String userID,
  name,
  pass,
  email;

  UserModel({this.userID, this.name, this.pass, this.email});

 factory UserModel.fromJson(Map<String, dynamic> json){
   return UserModel(
     userID:json['_userID'],
     name:json['_name'],
     pass:json['_pass'],
     email:json['_email'],
   );
 }
}