import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Test',
      style: optionStyle,
    ),
    Text(
      'Index 2: Business',
      style: optionStyle,
    ),
    Text(
      'Index 3: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            title: Text('Bookmark'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

class DemandResourceWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DemandWidgetState();
  }
}

class _DemandWidgetState extends  State<DemandResourceWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

class AddResourceWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddResourceWidgetState();
  }

}

class _AddResourceWidgetState extends State<AddResourceWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

class ChatWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}


