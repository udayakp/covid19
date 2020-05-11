import 'dart:developer';

import 'package:app_flutter/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  UserList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthService(),
        child: Scaffold(
            appBar: AppBar(title: Text(widget.title), actions: <Widget>[
              IconButton(
                icon: Icon(Icons.help),
                tooltip: 'Help',
                onPressed: () {
                  Navigator.pushNamed(context, '/help');
                },
              )
            ]),
            body: Consumer<AuthService>(
            builder: (context, authService, child) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: RaisedButton(
                  child: Text("Get List"),
                  onPressed: () {
                    authService.getuserlist();
                  }),
            );
            log("Trigger rebuild");
                if (authService.state == AuthStatus.FETCHED) {
                  return ListCreateWidget();
                }
                else{
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text("No Data Yet")
                  );
                }
          },
        )
        )
    );
  }
}

class ListCreateWidget extends StatefulWidget {
  @override
  _ListCreateWidgetState createState() => _ListCreateWidgetState();
}

class _ListCreateWidgetState extends State<ListCreateWidget> {
  @override
  Widget build(BuildContext context) {
    Consumer<AuthService>(
          builder: (context, authService, child) {
            return Container(
              //add list logic
            );
          }
      
    );
  }
}
