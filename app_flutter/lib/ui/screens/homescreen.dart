import 'package:app_flutter/notifiers/UserNotifier.dart';
import 'package:app_flutter/ui/screens/list.dart';
import 'package:app_flutter/ui/screens/loginscreen.dart';
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
  int _counter = 0;

  // Place holder for future API result
  bool signedIn = true;

  //bool _signedIn = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //bool _isSignedIn() {
  //  setState(() {
  //    if(signedIn) {
        // Add API Logic here and set `_signedIn` state and other variables if required
  //      _signedIn = true;
  //    } else {
  //     _signedIn = false;
  //    }
  //    return _signedIn;
  //  });
  
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                  MaterialPageRoute(builder: (context) => LoginPage(title:'Login')),
                );                
              } ,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Users List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserList()),
                );                
              } ,
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
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
