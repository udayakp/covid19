import 'package:app_flutter/models/user.dart';
import 'package:app_flutter/notifiers/UserNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  var users = new List<UserModel>();

  _getusers(){
    setState(()  {
          users = UserNotifier().getUsers();
        }); 
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _getusers();
    }
  @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
    }  
  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user list"),
      ),
      body: Consumer<UserNotifier>(
        builder: (context, userModel, child) {
          return ListView.builder(
            itemCount: userModel.users.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(userModel.users[index].userName));
            }
          );
        }
      ),
    );
  }
}
