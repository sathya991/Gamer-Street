import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/providers/google_signin_provider.dart';
import 'package:gamer_street/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _curUserInstance = FirebaseAuth.instance;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(_curUserInstance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapShot.hasData) {
            var list = snapShot.data! as DocumentSnapshot;
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
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
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.more),
                    title: Text("Know more"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  VerticalDivider(
                    width: 2,
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                    onTap: () {
                      final provider = Provider.of<GoogleSigninProvider>(
                          context,
                          listen: false);
                      if (provider.isGoogleSignin) {
                        provider.googleLogout();
                      } else {
                        _curUserInstance.signOut();
                      }
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Drawer(
              child: Text("No user Found"),
            );
          }
        }
      },
    );
  }
}
