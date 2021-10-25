import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class TourneySmallDisplay extends StatefulWidget {
  String tourneyObj;
  TourneySmallDisplay(this.tourneyObj);
  @override
  State<TourneySmallDisplay> createState() => _TourneySmallDisplayState();
}

class _TourneySmallDisplayState extends State<TourneySmallDisplay> {
  Future<QuerySnapshot> getData() async {
    var stream = await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyObj)
        .collection('basicInfo')
        .get();
    widget.tourneyObj = "";
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: getData(),
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
                      padding: const EdgeInsets.only(right: 50),
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
