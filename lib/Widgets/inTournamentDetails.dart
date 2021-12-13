import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/multiplayerDisplay.dart';
import 'package:gamer_street/Widgets/screenshots.dart';
import 'package:gamer_street/Widgets/singlePlayerDisplay.dart';

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
  int noOfWinners = 0;
  bool isHost = false;
  var registeredUserStream;
  Future getHostId(String id) async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .get()
        .then((firstValue) async {
      setState(() {
        hostId = firstValue.get('hostId');
        matchState = firstValue.get('matchState');
        isHost = FirebaseAuth.instance.currentUser!.uid == hostId;
      });
    });
  }

  Future getWinnerNo(String id) async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .collection('additionalInfo')
        .get()
        .then((value) {
      setState(() {
        noOfWinners = value.docs.first.get('noOfWinners');
      });
    });
  }

  getRegisteredUsers(String id) {
    getHostId(id);
    getWinnerNo(id);
    setState(() {
      registeredUserStream = FirebaseFirestore.instance
          .collection('tournaments')
          .doc(id)
          .collection('registeredUsers')
          .snapshots();
    });
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
          while (matchState == "") {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (matchState == "inProgress") {
            return mainScreenWidget(snapshot, isHost, noOfWinners, matchState);
          } else {
            if (isHost) {
              return mainScreenWidget(
                  snapshot, isHost, noOfWinners, matchState);
            } else {
              return Screenshots();
            }
          }
        });
  }

  Widget mainScreenWidget(
      var snapshot, var isHost, int winnersNo, String matchStateNow) {
    return Container(
        padding: EdgeInsets.all(10),
        child: widget.gameName == 'Ludo King'
            ? SinglePlayerDisplay(
                snapshot: snapshot,
                isHost: isHost,
                noOfWinners: winnersNo,
                matchState: matchStateNow,
                tourneyId: widget.tourneyId,
              )
            : MultiPlayerDisplay(
                snapshot: snapshot,
                isHost: isHost,
                noOfWinners: winnersNo,
                matchState: matchStateNow,
                tourneyId: widget.tourneyId,
              ));
  }
}
