import 'package:flutter/material.dart';
import 'package:trackit/main.dart';
import 'package:trackit/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trackit/Data.dart';

class HomeScreen extends StatefulWidget {
  @override
  // const HomeScreen({Key key, this.user}) : super(key: key);
  // final User user;
  final Data data;
  HomeScreen({this.data});
  @override
  _HomeScreenState createState() => _HomeScreenState(data: data);
}

class _HomeScreenState extends State<HomeScreen> {
  final Data data;
  String username = "USER";
  _HomeScreenState({this.data});
  void initState() {
    _getThingsOnStart().then((value) {
      print('Async done');
    });
    super.initState();
  }

  Future _getThingsOnStart() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    print(_auth.currentUser);
    String id = _auth.currentUser.uid;
    await usersRef.once().then((DataSnapshot snapshot) {
      username = snapshot.value[id]["name"];
      data.username = username;
    });
  }

  Widget build(BuildContext context) {
    void fun() async {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Column(
                children: [
                  Text('USER: ' + data.username),
                  Text('EMAIL: ' + data.usermail),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("CLOSE"),
                )
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      drawer: MainDrawer(data: data),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: fun, child: Text("Click to get user details")),
            //Text(username),
          ],
        ),
      ),
    );
  }
}
