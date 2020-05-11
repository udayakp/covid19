import 'dart:async';
import 'dart:convert';
import 'package:app_flutter/models/auth.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter/models/user.dart';


class API {
  String baseURL;

  API(String baseURL) {
    this.baseURL = baseURL;
  }

  Future<List<User>> getUsers() async {
    final response = await http.get('$baseURL/users');

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<User>((json) => User.fromJson(json)).toList();
    } else {
      throw Exception(response.body);
    }
  } 

  Future<User> login(username, password) async {
    var loginURL = "$baseURL/login";
    final response = await http.post(loginURL,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
          "username": username,
          "password": password
        },
        encoding: Encoding.getByName("utf-8")
    );

    if(response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }


  Future<bool> register() async{
    final response = await http.post("$baseURL/register");
    if(response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }


  void getPosts() {

  }
}