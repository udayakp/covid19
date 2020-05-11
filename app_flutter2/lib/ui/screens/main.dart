import 'dart:developer';

import 'package:app_flutter/models/auth.dart';
import 'package:app_flutter/ui/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MainPageState createState() => _MainPageState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar loginErrorSnackBar =
    const SnackBar(content: Text('Error while loging in'));

class _MainPageState extends State<MainPage> {
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
                log("Trigger rebuild");
                if (authService.state == AuthStatus.NOT_LOGGED_IN) {
                  return LoginFormWidget();
                } else if (authService.state == AuthStatus.LOGGING_IN) {
                  return SpinnerWidget();
                } else {
                  return HomePage(
                    title: "Welcome",
                  );
                }
              },
            )));
  }
}

class SpinnerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SpinnerWidgetState();
  }
}

class _SpinnerWidgetState extends State<SpinnerWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          new CircularProgressIndicator(),
          new Text("Loading"),
        ],
      ),
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginFormWidgetState();
  }
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: TextFormField(
                controller: userNameController,
                decoration: InputDecoration(
                  labelText: "Username",
                ),
                cursorColor: Colors.black,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter some text";
                  } else {
                    return null;
                  }
                })),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter some text";
                } else {
                  return null;
                }
              },
            )),
        Consumer<AuthService>(
          builder: (context, authService, child) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: RaisedButton(
                  child: Text("Login"),
                  onPressed: () {
                    authService.login(
                        userNameController.text, passwordController.text);
                  }),
            );
          },
        )
      ],
    );
  }
}
