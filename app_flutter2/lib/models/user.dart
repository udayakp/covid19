class User {
  final String username;
  final String email;

  User({this.username, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      username: json['username'],
    );
  }
}