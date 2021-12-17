import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/services/GetUserData.dart';
import 'package:gamer_street/services/UserData.dart';
import 'package:gamer_street/services/Self.dart';

class Screenshots extends StatefulWidget {
  const Screenshots({Key? key}) : super(key: key);

  @override
  _ScreenshotsState createState() => _ScreenshotsState();
}

class _ScreenshotsState extends State<Screenshots> {
  void initState() {
    super.initState();
    fun();
  }

  late UserData j = new UserData();
  late Self h = new Self();
  String k = "sasi";
  late String? email = "";
  void fun() async {
    GetUserData.self().then((value) {
      setState(() {
        h = value;
      });
    });

    await GetUserData.usersData(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      setState(() {
        j = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(h.email),
      ),
    );
  }
}
