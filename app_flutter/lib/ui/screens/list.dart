import 'package:app_flutter/models/user.dart';
import 'package:app_flutter/services/api.dart';
import 'package:flutter/material.dart';


class UserList extends StatefulWidget {
  UserList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Api _api = Api();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lists'),
      ),
    body: ListWidget(),
      
    );
  }

  Widget ListWidget(){
    return FutureBuilder(
      builder: (context, listsnap) {
        if(listsnap.connectionState == ConnectionState.none && listsnap.hasData == null){
          return Container();
        }
        return ListView.builder(
          itemCount: listsnap.data.length(),
          itemBuilder: (context,index) {
            UserModel user = listsnap.data[index];
            return Column(
              children: <Widget>[
               Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Result: ${listsnap.data}'),
              )
              ],
            );
          }
        );
      },
      future: _api.getUsers(),
    );
  }
}