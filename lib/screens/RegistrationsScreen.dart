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
  @override
  Widget build(BuildContext context) {
    final _curUserUid = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(_curUserUid)
            .collection('registeredTourneys')
            .get(),
        builder: (ctx, snap) {
          return ListView.builder(
              itemBuilder: (ctx, index) {
                return TourneySmallDisplay();
              },
              itemCount: 0 // (snap as QuerySnapshot).docs.length,
              );
        });
  }
}
