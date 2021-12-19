import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/multiplayerDisplay.dart';
import 'package:gamer_street/Widgets/screenshots.dart';
import 'package:gamer_street/Widgets/singlePlayerDisplay.dart';

class InTournamentDetails extends StatefulWidget {
  final tourneyId;
  final gameName;
  final Function fun;
  const InTournamentDetails(
      {required this.gameName,
      required this.tourneyId,
      required this.fun,
      Key? key})
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

  Future setGameState(String id) async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .update({"matchState": "completed"});
    //     .then((firstValue) async {
    //   hostId = firstValue.get('hostId');
    //   matchState = firstValue.get('matchState');
    //   isHost = FirebaseAuth.instance.currentUser!.uid == hostId;
    // });
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mainScreenWidget(snapshot, isHost, noOfWinners, matchState),
                isHost
                    ? Container(
                        margin: EdgeInsets.only(top: 5, bottom: 0),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text('Confirmation..!'),
                                      content: Text(
                                          'Are you sure, Match is completed?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('CANCEL'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setGameState(widget.tourneyId);
                                          },
                                          child: Text('YES'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                                height: 45,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Text("Match Completed..?"))),
                      )
                    : SizedBox()
              ],
            );
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
