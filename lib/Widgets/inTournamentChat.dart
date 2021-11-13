import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/messages.dart';
import 'package:gamer_street/Widgets/messagetype.dart';

class InTournamentChat extends StatefulWidget {
  final tourneyId;
  const InTournamentChat(this.tourneyId, {Key? key}) : super(key: key);

  @override
  State<InTournamentChat> createState() => _InTournamentChatState();
}

class _InTournamentChatState extends State<InTournamentChat> {
  // String hostId = "";
  // bool isRegistered = false;
  // getRegisterUser() async {
  //   await FirebaseFirestore.instance
  //       .collection('tournaments')
  //       .doc(widget.tourneyId)
  //       .collection('regsiteredUsers')
  //       .get()
  //       .then((value) {
  //     value.docs.contains(FirebaseAuth.instance.currentUser!.uid);
  //   });
  // }

  // getUserData() async {
  //   await FirebaseFirestore.instance
  //       .collection('tournaments')
  //       .doc(widget.tourneyId)
  //       .get()
  //       .then((value) {
  //     hostId = value.get('hostId');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Messages(widget.tourneyId), MessageType(widget.tourneyId)],
    );
  }
}
