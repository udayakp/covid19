import 'package:app_flutter/ui/screens/homescreen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _counter = 0;

  String email;
  String userName;
  String password;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final formKey = new GlobalKey<FormState>();

  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  newUserCheck() {
    return true;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            tooltip: 'Account',
            onPressed: () {
            scaffoldKey.currentState.showSnackBar(snackBar);
            },
          )

        ]
      ),
      drawer: Drawer(    
         child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child:Text('Header'),
              decoration:BoxDecoration(
                color: Colors.blue,
              )
              //Icon(Icons.account_box),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Account'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title:'Reloaded page')),
                );
              } ,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Close'),
              onTap: () => { Navigator.pop(context), },
            )
          ],
        )
      ),
      body: Center(        
        child: Container(
          height:250.0,
          width:300.0,
          child: Column(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[   
              Padding(
                  padding: EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      top: 20.0,
                      bottom: 5.0),
                  child: Container(
                    height: 50.0,
                    child: TextFormField(
                      decoration:
                          InputDecoration(hintText: 'userName'),
                      validator: (value) => value.isEmpty
                          ? 'Username is required':null,
                      onChanged: (value) {
                        this.userName = value;
                      },
                    ),
                  )),
               Padding(
                  padding: EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      top: 20.0,
                      bottom: 5.0),
                  child: Container(
                    height: 50.0,
                    child: TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Email'),
                      validator: (value) => value.isEmpty
                          ? 'Email is required'
                          : validateEmail(value.trim()),
                      onChanged: (value) {
                        this.email = value;
                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      top: 20.0,
                      bottom: 5.0),
                  child: Container(
                    height: 50.0,
                    child: TextFormField(
                      obscureText: true,
                      decoration:
                          InputDecoration(hintText: 'Password'),
                      validator: (value) => value.isEmpty
                          ? 'Password is required'
                          : null,
                      onChanged: (value) {
                        this.password = value;
                      },
                    ),
                  )),
                InkWell(
                  onTap: () {
                    if (checkFields()) {
                      if(password=='admin'){
                        MyHomePage();
                      }else{
                        LoginPage();
                      }
                    }
                  },
                  child: Container(
                      height: 40.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                      ),
                      child: Center(child: Text('Sign in'))
                      )
                    )
                  ],
                ),
              )
            ],
          )                  

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}