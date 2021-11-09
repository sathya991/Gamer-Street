import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  Future<void> add() async {
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
            await FirebaseFirestore.instance
                .collection('tournaments')
                .doc(widget.tId)
                .collection('registeredUsers')
                .doc()
                .set({
              "player": FirebaseAuth.instance.currentUser!.uid,
              "userName": data['userName'],
              'phone': data['phone'],
              'email': data['email']
            });
            await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('PlayerGames')
                .doc()
                .set({"Tid": widget.tId});
          } else
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

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
            future: Future.wait([basicData(), additionalData()]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // final doc = snapshot.data!.docs.first;
                return Column(children: [
                  BasicInfo(snapshot: (snapshot.data! as dynamic)[0]),
                  AdditionalInfo(snapshot: (snapshot.data! as dynamic)[1]),
                  Container(
                    height: 300,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(2),
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          add();
                        },
                        child: Text(
                          "Rigister",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                  ),
                ]);
              } else
                return Text(widget.tId);
            }));
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
                  "            Game : ${doc['game']}",
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
  const AdditionalInfo({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doc = snapshot.docs.first;
    return Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.all(2),
        color: Colors.black87,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                "Team Mode :${doc['teamMode']}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              ),
            ),
            Container(
              child: Text(
                "Map :${doc['map']}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              ),
            ),
          ],
        ));
  }
}
