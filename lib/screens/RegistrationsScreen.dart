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
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemBuilder: (ctx, index) {
                  return TourneySmallDisplay(snapshot.data!.docs[index]['Tid']);
                },
                itemCount: snapshot.data!.docs.length);
          }
        });
  }
}
