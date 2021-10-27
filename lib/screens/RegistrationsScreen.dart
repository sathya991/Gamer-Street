import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/tourneySmallDisplay.dart';
import 'package:gamer_street/Widgets/new.dart';

class RegistrationsScreen extends StatefulWidget {
  const RegistrationsScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationsScreen> createState() => _RegistrationsScreenState();
}

class _RegistrationsScreenState extends State<RegistrationsScreen> {
  var stream;
  @override
  void initState() {
    super.initState();
    setState(() {
      stream = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('registeredTourneys')
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var width = screenWidth;
    if (screenWidth > 700) width = screenWidth / 2;

    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 5,
              ),
            );
          } else {
            return ListView.builder(
                padding: EdgeInsets.only(bottom: 200),
                itemBuilder: (ctx, index) {
                  return Container(
                    padding: EdgeInsets.all(2),
                    child: Card(
                      elevation: 4,
                      child: TourneySmallDisplay(
                          snapshot.data!.docs[index]['Tid'], width),
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length);
          }
        });
  }
}
