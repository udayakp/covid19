import 'dart:convert';
import 'dart:developer';

import 'package:app_flutter/models/user.dart';
import "package:http/http.dart" as http;

class Api{
  final String _baseUrl = "http://localhost:3000/";

  //get user details

Future<List<UserModel>> getUserAuth(String userId, String pass) async {
  final response = await http.post(
    '$_baseUrl/api/login',
      body: json.encode(
        {'username': '$userId',
         'password':'$pass'},
      ),
      headers: {'Content-Type': "application/json"},
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception(response.body);
    }
}

Future<List<UserModel>> addUser(String userId, String pass,String name, String email) async {
  final response = await http.post(
    '$_baseUrl/api/register',
      body: json.encode(
        {'username': '$userId',
         'password':'$pass',
         'email':'$email'}
      ),
      headers: {'Content-Type': "application/json"},
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception(response.body);
    }
}

Future<List<UserModel>> getUsers() async {
  final response = await http.get('$_baseUrl/api/users');

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception(response.body);
    }
}
}
