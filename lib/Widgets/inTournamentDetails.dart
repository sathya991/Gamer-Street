import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/multiplayerDisplay.dart';
import 'package:gamer_street/Widgets/screenshots.dart';
import 'package:gamer_street/Widgets/singlePlayerDisplay.dart';

class InTournamentDetails extends StatefulWidget {
  final tourneyId;
  final gameName;
  final hostId;
  final matchState;
  final isHost;
  final noOfWinners;
  const InTournamentDetails(this.tourneyId, this.gameName, this.hostId,
      this.matchState, this.isHost, this.noOfWinners,
      {Key? key})
      : super(key: key);

  @override
  State<InTournamentDetails> createState() => _InTournamentDetailsState();
}

class _InTournamentDetailsState extends State<InTournamentDetails> {
  List registeredNames = [];
  var registeredUserStream;

  getRegisteredUsers(String id) {
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
          if (widget.matchState == "") {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (widget.matchState == "inProgress") {
            return mainScreenWidget(
                snapshot, widget.isHost, widget.noOfWinners, widget.matchState);
          } else if (widget.matchState == "completed") {
            if (widget.isHost) {
              return mainScreenWidget(snapshot, widget.isHost,
                  widget.noOfWinners, widget.matchState);
            } else {
              return Screenshots();
            }
          } else {
            return CircularProgressIndicator();
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
