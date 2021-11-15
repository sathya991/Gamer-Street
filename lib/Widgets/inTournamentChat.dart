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
  String hostId = "";
  bool isRegistered = false;
  String tourneyId = "";
  int chatLength = 0;
  late Stream<QuerySnapshot> registeredData;
  getRegisterUser() {
    return FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyId)
        .collection('registeredUsers')
        .snapshots();
  }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyId)
        .get()
        .then((value) {
      hostId = value.get('hostId');
    });
  }

  @override
  void initState() {
    super.initState();
    registeredData = getRegisterUser();
    getUserData();
    tourneyId = widget.tourneyId;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: registeredData,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          Widget widget = Container();
          var len = snapshot.data!.docs.length;
          var el;
          if ((hostId == FirebaseAuth.instance.currentUser!.uid)) {
            widget = officialChat(true);
            isRegistered = true;
          } else {
            for (int i = 0; i < len; i++) {
              el = snapshot.data!.docs[i];
              if ((el.get('player1') ==
                  FirebaseAuth.instance.currentUser!.uid)) {
                isRegistered = true;
                widget = officialChat(false);
              }
            }
          }
          if (!isRegistered) {
            widget =
                emptyDataWidget("Please register in this tournament to chat.");
          }

          return widget;
        });
  }

  Widget emptyDataWidget(String txt) => Container(
        child: Center(
          child: Text(txt),
        ),
      );

  Widget officialChat(bool isHost) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Messages(tourneyId, isHost),
          MessageType(tourneyId),
        ],
      );
}
