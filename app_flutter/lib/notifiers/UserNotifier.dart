import 'package:app_flutter/models/user.dart';
import 'package:app_flutter/services/api.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class UserNotifier extends ChangeNotifier {
  List<UserModel> _users;
  UserModel _singleUser;
  Status _status;
  Api _api = Api();

  List<UserModel> get users => _users;
  UserModel get singleUser => _singleUser;
  Status get status => _status;

  getUsers() async {
    _status = Status.loading;
    notifyListeners();
    _users = await _api.getUsers();
    _status = Status.done;
    notifyListeners();
  }

  getUserAuth(String id, String pass) async {
    _status = Status.loading;
    notifyListeners();
    _singleUser = await getUserAuth(id,pass);
    _status = Status.done;
    notifyListeners();
  }
}