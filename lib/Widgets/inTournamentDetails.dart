import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/multiplayerDisplay.dart';
import 'package:gamer_street/Widgets/screenshots.dart';
import 'package:gamer_street/Widgets/singlePlayerDisplay.dart';
import 'package:gamer_street/screens/profile.dart';

class InTournamentDetails extends StatefulWidget {
  final tourneyId;
  final gameName;
  const InTournamentDetails(this.tourneyId, this.gameName, {Key? key})
      : super(key: key);

  @override
  State<InTournamentDetails> createState() => _InTournamentDetailsState();
}

class _InTournamentDetailsState extends State<InTournamentDetails> {
  List registeredNames = [];
  String hostId = "";
  String matchState = "";
  var registeredUserStream;
  Future getHostId(String id) async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .get()
        .then((firstValue) async {
      hostId = firstValue.get('hostId');
      matchState = firstValue.get('matchState');
    });
  }

  getRegisteredUsers(String id) {
    getHostId(id);
    registeredUserStream = FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .collection('registeredUsers')
        .snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRegisteredUsers(widget.tourneyId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: registeredUserStream,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.data!.docs.length == 0) {
            return Center(
              child: Text("No users Registered yet"),
            );
          }
          bool isHost = FirebaseAuth.instance.currentUser!.uid == hostId;
          if (matchState == "inProgress") {
            return mainScreenWidget(snapshot, isHost);
          } else {
            if (isHost) {
              return mainScreenWidget(snapshot, isHost);
            } else {
              return Screenshots();
            }
          }
        });
  }

  Widget mainScreenWidget(var snapshot, var isHost) {
    return Container(
        padding: EdgeInsets.all(10),
        child: widget.gameName == 'Ludo King'
            ? SinglePlayerDisplay(
                snapshot: snapshot,
                isHost: isHost,
              )
            : MultiPlayerDisplay(
                snapshot: snapshot,
                isHost: isHost,
              ));
  }
}
