import 'package:app_flutter/models/auth.dart';
import 'package:app_flutter/ui/screens/home.dart';
import 'package:app_flutter/ui/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/main': (context) => MainPage(),
        '/home': (context) => HomePage(),
//        '/help': (context) => HelpPage();
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: "COVID Help Portal"),
    );
  }
}

