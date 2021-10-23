import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/providers/tourney_provider.dart';
import 'package:provider/provider.dart';

class TourneySmallDisplay extends StatefulWidget {
  //final QueryDocumentSnapshot<Object?>
  final String tourneyObj;
  TourneySmallDisplay(this.tourneyObj);

  @override
  State<TourneySmallDisplay> createState() => _TourneySmallDisplayState();
}

class _TourneySmallDisplayState extends State<TourneySmallDisplay> {
  late Future val;
  var stream;
  var game;

  Future<QuerySnapshot> getData() {
    print(widget.tourneyObj);
    return FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyObj)
        .collection('basicInfo')
        .get();
  }

  Future streamss() {
    return FirebaseFirestore.instance.collection("games").get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: getData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          else if (snapshot.hasData) {
            /* return Text((snapshot).data!.docs.first['entryFee'].toString());*/
            // print(snapshot.data!.docs.first['entryFee']);
          }
          return Text("nodata");
        });

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
