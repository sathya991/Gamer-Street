import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/providers/tourney_provider.dart';
import 'package:provider/provider.dart';

class TourneySmallDisplay extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> tourneyObj;
  TourneySmallDisplay(this.tourneyObj);

  @override
  State<TourneySmallDisplay> createState() => _TourneySmallDisplayState();
}

class _TourneySmallDisplayState extends State<TourneySmallDisplay> {
  late Future val;
  Future getData() async {
    return await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyObj.id.toString())
        .collection('basicInfo')
        .get();
  }

  @override
  void initState() {
    super.initState();
    val = getData();
  }

  @override
  Widget build(BuildContext context) {
    String v = "";
    val.then((value) {
      v = value.docs.first.id;
    });
    return Text(v);

    // return Padding(
    //   padding: EdgeInsets.all(8),
    //   child: Card(
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Container(
    //           height: 150,
    //           width: 150,
    //           child: Image.network(data['url'], fit: BoxFit.fill),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(right: 50),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Row(
    //                 children: [
    //                   Text(
    //                     "Game: ",
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.bold, fontSize: 15),
    //                   ),
    //                   Text(dataNow['game']),
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Row(
    //                 children: [
    //                   Text(
    //                     "Entry Fee: ",
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.bold, fontSize: 15),
    //                   ),
    //                   Text("Rs ${basicDataNow['entryFee'].toString()}"),
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Row(
    //                 children: [
    //                   Text(
    //                     "Prize Money: ",
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.bold, fontSize: 15),
    //                   ),
    //                   Text("Rs ${basicDataNow['prizeMoney'].toString()}"),
    //                 ],
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
