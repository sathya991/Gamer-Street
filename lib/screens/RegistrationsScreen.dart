import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/tourneySmallDisplay.dart';

class RegistrationsScreen extends StatefulWidget {
  const RegistrationsScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationsScreen> createState() => _RegistrationsScreenState();
}

class _RegistrationsScreenState extends State<RegistrationsScreen> {
  var stream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('registeredTourneys')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
                key: ValueKey(i),
                itemBuilder: (ctx, index) {
                  i++;
                  return TourneySmallDisplay(snapshot.data!.docs[index]);
                },
                itemCount: snapshot.data!.docs.length);
          }
        });
  }
}
