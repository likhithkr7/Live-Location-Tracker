import 'package:flutter/material.dart';
import 'package:trackit/main.dart';
import 'package:trackit/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trackit/Data.dart';
import 'package:trackit/live_tracker.dart';
import 'package:trackit/live_pager.dart';

class HomeScreen extends StatefulWidget {
  @override
  final Data data;
  final User user;
  HomeScreen({this.data, this.user});
  @override
  _HomeScreenState createState() => _HomeScreenState(data: data);
}

class _HomeScreenState extends State<HomeScreen> {
  final Data data;
  String username;
  List<String> users = [];
  List<String> user_id = [];
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
    data.id = id;
    await usersRef.once().then((DataSnapshot snapshot) {
      username = snapshot.value[id]["name"];
      data.username = username;
      var keys = snapshot.value.keys;
      var values = snapshot.value;
      for (var key in keys) {
        if (key == id) continue;
        users.add(values[key]["name"]);
        user_id.add(key);
      }
      for (int i = 0; i < users.length; i++) print(users[i]);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home page'),
        ),
        drawer: MainDrawer(data: data),
        body: Container(
            height: MediaQuery.of(context).size.height*0.80,
            child: new ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(users[index]),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            // textColor: const Color(0xFF6200EE),
                            onPressed: () {
                              data.user_id = user_id[index];
                              // Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Page2(
                                          data: data,
                                        )),
                              );
                            },
                            child: const Text('Locate'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        );
  }
}
