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
  var fut;
  void firstData() {
    setState(() {
      fut = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('registeredTourneys')
          .get();
    });
  }

  @override
  void initState() {
    super.initState();
    firstData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: fut,
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
