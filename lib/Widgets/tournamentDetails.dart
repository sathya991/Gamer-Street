import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamer_street/screens/tournamentDetailsRegistration.dart';

class TournamentDetails extends StatefulWidget {
  final tId;

  const TournamentDetails({Key? key, required this.tId}) : super(key: key);

  @override
  _TournamentDetailsState createState() => _TournamentDetailsState();
}

class _TournamentDetailsState extends State<TournamentDetails> {
  FToast fToast = FToast();

  @override
  void initState() {
    FToast fToast;
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  Future<QuerySnapshot> basicData() async {
    return await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tId)
        .collection('basicInfo')
        .get();
  }

  Future<QuerySnapshot> additionalData() async {
    return await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tId)
        .collection('additionalInfo')
        .get();
  }

  String game = '';
  String hostId = '';
  int teamCount = 1;
  Future gameName() async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tId)
        .get()
        .then((firstValue) async {
      game = firstValue.get('game');
      hostId = firstValue.get('hostId');
    });
  }

  void teamCountUpdate(int count) {
    teamCount = count;
  }

  // void navigationtoRegistration(String game) {
  //   switch (game) {
  //     case 'BGMI':
  //   }
  // }

  Future<void> checkPhoneAndNavigate() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      var k = data['phone'];
      if (k.toString().isNotEmpty) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('PlayerGames')
            .where("Tid", isEqualTo: widget.tId)
            .get()
            .then((value) async {
          if (value.docs.isEmpty) {
            // add();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TournamentDetailsRegistration(
                          game: game,
                          teamSize: teamCount,
                          tId: widget.tId,
                          hostId: hostId,
                        )));

            // Navigator.of(context).pushNamed(
            //     TournamentDetailsRegistration.tournamentDetailsRegistration,
            //     arguments: [game, teamCount, widget.tId]);
          } else {
            fToast.showToast(
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outlined,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "Already Registered",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              gravity: ToastGravity.BOTTOM,
              toastDuration: Duration(seconds: 2),
            );
          }
        });
      } else {
        fToast.showToast(
          child: Container(
            height: 60,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.black,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.mobile_friendly_outlined,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  "Verify your Mobile number..",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          gravity: ToastGravity.CENTER,
          toastDuration: Duration(seconds: 2),
        );
      }
    });
  }

  // Future<void> add() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((value) async {
  //     Map<String, dynamic> data = value.data() as Map<String, dynamic>;

  // await FirebaseFirestore.instance
  //     .collection('tournaments')
  //     .doc(widget.tId)
  //     .collection('registeredUsers')
  //     .doc()
  //     .set({
  //   "players": [
  // {
  //   "player": FirebaseAuth.instance.currentUser!.uid,
  //   "playerAccount": false,
  //   "userName": data['userName'],
  //   'phone': data['phone'],
  //   'email': data['email']
  // },
  // {
  //   "player": FirebaseAuth.instance.currentUser!.uid,
  //   "playerAccount": false,
  //   "userName": data['userName'],
  //   'phone': data['phone'],
  //   'email': data['email']
  // },
  // {
  //   "player": FirebaseAuth.instance.currentUser!.uid,
  //       "playerAccount": false,
  //       "userName": data['userName'],
  //       'phone': data['phone'],
  //       'email': data['email']
  //     },
  //     {
  //       "player": FirebaseAuth.instance.currentUser!.uid,
  //       "playerAccount": false,
  //       "userName": data['userName'],
  //       'phone': data['phone'],
  //       'email': data['email']
  //     }
  //   ]
  // });
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('PlayerGames')
  //         .doc()
  //         .set({"Tid": widget.tId});
  //   });
  // }

  void toastMessage(String msg) {
    fToast.showToast(
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.black,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.no_accounts,
              color: Colors.green,
            ),
            SizedBox(
              width: 12.0,
            ),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: FutureBuilder(
              future: Future.wait([basicData(), additionalData(), gameName()]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // final doc = snapshot.data!.docs.first;
                  return Column(children: [
                    BasicInfo(snapshot: (snapshot.data! as dynamic)[0]),
                    AdditionalInfo(
                        snapshot: (snapshot.data! as dynamic)[1],
                        game: game,
                        fun: teamCountUpdate),
                    Container(
                      height: 300,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(2),
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            if (hostId ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              toastMessage('You cannot Play this Tournament');
                            } else {
                              checkPhoneAndNavigate();
                            }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                    ),
                  ]);
                } else
                  return Text(widget.tId);
              })),
    );
  }
}

class BasicInfo extends StatelessWidget {
  final QuerySnapshot snapshot;
  const BasicInfo({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doc = snapshot.docs.first;
    return Container(
        child: Stack(
      children: [
        Container(
          height: 270,
          padding: const EdgeInsets.all(2.0),
          child: Image(fit: BoxFit.cover, image: NetworkImage(doc['url'])),
        ),
        Positioned(
          top: 10,
          right: 20,
          bottom: 10,
          child: Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(40),
            alignment: Alignment.centerLeft,
            color: Colors.black54,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    child: Text(
                  "Game : ${doc['game']}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20),
                )),
                Container(
                  margin: EdgeInsets.all(2),
                  child: Row(children: [
                    Text(
                      "      Entry Fee : ${doc['entryFee'].toString()}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    )
                  ]),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  child: Row(children: [
                    Text(
                      "Prize Money : ${doc['prizeMoney'].toString()}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    )
                  ]),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  child: Text(
                    ("${DateFormat.yMMMd().add_jm().format(DateTime.parse(doc['registrationEndTime'].toDate().toString()))}")
                        .toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  child: Text(
                    ("${DateFormat.yMMMd().add_jm().format(DateTime.parse(doc['tourneyTime'].toDate().toString()))}")
                        .toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class AdditionalInfo extends StatelessWidget {
  final QuerySnapshot snapshot;
  final String game;
  final Function fun;

  const AdditionalInfo(
      {Key? key, required this.snapshot, required this.game, required this.fun})
      : super(key: key);

  static Widget buildAdditionalInfo(String head, String value) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Text(
        head + ":  " + value,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doc = snapshot.docs.first;
    List l = [];
    int index = -1;
    List heading = [];
    switch (game) {
      case "BGMI":
        String teamSize = doc['teamMode'];
        if (teamSize == 'Solo') {
          fun(1);
        } else if (teamSize == 'Duo') {
          fun(2);
        } else {
          fun(4);
        }
        l = [
          doc['map'],
          teamSize,
        ];
        heading = ['Map', 'Team Mode'];
        break;
      case "Ludo King":
        l = [
          doc['noOfPlayers'],
        ];
        heading = ['No of Players'];
        break;
    }

    return Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.all(2),
        color: Colors.black87,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...l.map((value) {
              index = index + 1;
              return buildAdditionalInfo(heading[index], value.toString());
            }).toList()
            // buildAdditionalInfo(l[0].toString()),
            // Container(
            //   alignment: Alignment.center,
            //   width: double.infinity,
            //   child: Text(
            //     "Team Mode :${doc['teamMode']}",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.w300,
            //         fontSize: 20),
            //   ),
            // ),
            // Container(
            //   child: Text(
            //     "Map :${doc['map']}",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.w300,
            //         fontSize: 20),
            //   ),
            // ),
          ],
        ));
  }
}
