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
    return FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyObj)
        .collection('basicInfo')
        .get();
  }

  Future<QuerySnapshot> streamss() {
    return FirebaseFirestore.instance.collection("games").get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([streamss(), getData()]),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          else if (snapshot.hasData) {
            ((snapshot.data as dynamic)[0] as QuerySnapshot)
                .docs
                .map((e) => print(e.data.toString()));

            var gameDocument = (snapshot.data as dynamic)[1] as QuerySnapshot;
            var idGame =
                ((snapshot.data as dynamic)[1] as QuerySnapshot).docs.first;
            return Column(
              children: [
                Text(idGame['entryFee'].toString()),
                Text(((snapshot.data as dynamic)[0] as QuerySnapshot)
                    .docs
                    .first['game']
                    .toString()),
                Text(idGame.id),
              ],
            );
          } else
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
