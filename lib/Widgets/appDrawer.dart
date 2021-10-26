import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/providers/google_signin_provider.dart';
import 'package:gamer_street/screens/Hosting.dart';
import 'package:gamer_street/screens/settingsScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final _curUserInstance = FirebaseAuth.instance;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: Colors.red,
            backgroundColor: Colors.black,
          );
        } else if (snapShot.hasData) {
          var list = snapShot.data! as DocumentSnapshot;
          var _isHosting = list['admin'];
          return Drawer(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(list['userName']),
              accountEmail: Text(
                list['email'],
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("User Details"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, SettingsScreen.settingScreenRoute);
              },
            ),
            ListTile(
              leading: Icon(Icons.more),
              title: Text("Know more"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _isHosting
                ? ListTile(
                    leading: Icon(Icons.emoji_events),
                    title: Text("H O S T"),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(
                          Hosting.HostingRoute,
                          arguments: _isHosting);
                      //   Navigator.of(context).pushNamed(Hosting.HostingRoute);
                    },
                  )
                : VerticalDivider(
                    width: 2,
                  ),
          ]));
        }
        return Container(
          alignment: Alignment.center,
          color: Colors.black12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Colors.green,
              ),
              Text(
                "Hey Dude! turn on your Internet, Man.",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
              )
            ],
          ),
        );
      },
    );
  }
}
