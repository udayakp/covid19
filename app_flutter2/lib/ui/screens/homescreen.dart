import 'package:app_flutter/ui/screens/main.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
            scaffoldKey.currentState.showSnackBar(snackBar);
            },
          )
        ]
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
        ),
      ),
    );
  }
}

class AppDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState()  => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  bool _signedIn = false;
  @override
  void initState() {
    super.initState();
    _signedIn = false;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Covid 19 Community'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: ( _signedIn ? Text('Account') : Text('Sign in')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        )
    );
  }
}