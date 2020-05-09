class UserModel{
  final String userName,
  pass,
  email;

  UserModel({this.userName, this.pass, this.email});

 factory UserModel.fromJson(Map<String, dynamic> json){
   return UserModel(
     userName:json['_userName'],
     pass:json['_pass'],
     email:json['_email'],
   );
 }
}