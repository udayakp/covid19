class UserModel{
  String userName;
  String pass;
  String email;

  UserModel({this.userName, this.pass, this.email});

 /* UserModel(String userName, String pass, String email){
    this.userName = userName;
    this.pass = pass;
    this.email = email;
  }*/
 factory UserModel.fromJson(Map<String, dynamic> json){
   return UserModel(
     userName:json['_userName'],
     pass:json['_pass'],
     email:json['_email'],
   );  
 }
  Map toJson(){
    return {'userName':userName,'email':email};
  }

}