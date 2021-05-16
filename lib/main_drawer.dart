import 'package:flutter/material.dart';
import 'package:trackit/live_pager.dart';
import 'package:trackit/Data.dart';
/*import 'package:live_loc_tracker/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MainDrawer extends StatefulWidget {
  @override
  const MainDrawer({
    Key key,
    this.user}) : super(key: key);
  final User user;
  _MainDrawerState createState() => _MainDrawerState();
}*/

class MainDrawer extends StatelessWidget {
  @override
  /*final User user;
   MainDrawer({
    this.user,
    Key key}) : super(key:key);*/
  final Data data;
  MainDrawer({this.data});
  Widget build(BuildContext context) {
    /* print(user);
    usersRef.once().then((DataSnapshot snapshot){
      String id=widget.user.uid;
      _username=snapshot.value[id]["name"];
      _usermail=snapshot.value[id]["mail"];
    });*/
    return new Drawer(
      child: new Column(
        children: <Widget>[
          new Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                    ),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/LikhithRK.PNG'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    data.username,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    data.usermail,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text(
              'Live Tracking',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Page1()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
