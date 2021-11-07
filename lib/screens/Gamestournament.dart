import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamer_street/Widgets/tourneySmallDisplay.dart';

class GamesTournament extends StatelessWidget {
  const GamesTournament({Key? key}) : super(key: key);
  static const gamesTournamentRoute = '/gamesTournamentList';

  void RegisterTid(String Tid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('registeredTourneys')
        .doc()
        .set({
      'Tid': Tid,
    });
  }

  Future<QuerySnapshot> getTid() {
    return FirebaseFirestore.instance.collection('tournaments').get();
  }

  @override
  Widget build(BuildContext context) {
    final gamename = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(gamename),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: getTid(),
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 5,
                ),
              );
            } else if (snap.hasData) {
              var doc = snap.data!.docs;
              return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      elevation: 25,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20))),
                      child: Column(
                        children: [
                          TourneySmallDisplay(doc[index].id),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextButton(
                                onPressed: () {
                                  RegisterTid(doc[index].id);
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                )),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text("No Tournaments Available"),
              );
            }
          }),
    );
  }
}
