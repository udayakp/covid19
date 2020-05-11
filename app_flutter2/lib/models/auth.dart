import 'dart:developer';

import 'package:app_flutter/api.dart';
import 'package:flutter/foundation.dart';

enum AuthStatus {
  LOGGED_IN,
  LOGGING_IN,
  NOT_LOGGED_IN,
  FETCHING_DATA,
  FETCHED
}

class AuthService extends ChangeNotifier {
  var userInfo;
  var userList;
  var state = AuthStatus.NOT_LOGGED_IN;
  //var baseURL = "http://10.0.2.2:3000/api";
  var baseURL = "http://localhost:3000/api";
  get loginState => this.state;
  get user => this.userInfo;
  get userData => this.userList;

  login(username, password) async {
    var apiClient = API(baseURL);

    state = AuthStatus.LOGGING_IN;
    notifyListeners();
    userInfo = await apiClient.login(username, password);
    log(username);
    log(password);
    log(userInfo.toString());
    log(state.toString());
    if (userInfo != null) {
      state = AuthStatus.LOGGED_IN;
    } else {
      state = AuthStatus.NOT_LOGGED_IN;
    }
    notifyListeners();
  }

  getuserlist() async {
    var apiClient = API(baseURL);

    state = AuthStatus.FETCHING_DATA;
    notifyListeners();
    userList = await apiClient.getUsers();
    if(userList != null) {
      state = AuthStatus.FETCHED;
    }
    notifyListeners();

  }
}