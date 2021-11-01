import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class TourneySmallDisplay extends StatefulWidget {
  final String tourneyObj;
  TourneySmallDisplay(this.tourneyObj);
  @override
  State<TourneySmallDisplay> createState() => _TourneySmallDisplayState();
}

class _TourneySmallDisplayState extends State<TourneySmallDisplay> {
  Stream<QuerySnapshot> getData() {
    var stream = FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyObj)
        .collection('basicInfo')
        .snapshots();
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getData(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return LoadingRotating.square(
              borderColor: Colors.orange,
              size: 50,
            );
          } else if (snap.hasData) {
            var data = snap.data!.docs.first;
            return Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: Image.network(data['url'], fit: BoxFit.fill),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Game: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(data['game']),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Entry Fee: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text("Rs ${data['entryFee'].toString()}"),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Prize Money: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text("Rs ${data['prizeMoney'].toString()}"),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Text("No tourney");
          }
        });
  }
}
