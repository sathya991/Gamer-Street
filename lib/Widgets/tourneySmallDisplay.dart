import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TourneySmallDisplay extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> tourneyObj;
  TourneySmallDisplay(this.tourneyObj);

  @override
  State<TourneySmallDisplay> createState() => _TourneySmallDisplayState();
}

class _TourneySmallDisplayState extends State<TourneySmallDisplay> {
  var tourneyQuery;
  var fut;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // tourneyQuery = FirebaseFirestore.instance
    //     .collection('tournaments')
    //     .doc(widget.tourneyObj.id.trim())
    //     .collection('basicInfo')
    //     .snapshots();
    fut = FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyObj.id.trim())
        .collection('basicInfo')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    Map<String, dynamic> basicData;
    Map<String, dynamic> data;
    Future getTourneyData() async {
      try {
        QuerySnapshot fut = await FirebaseFirestore.instance
            .collection('tournaments')
            .doc(widget.tourneyObj.id.trim())
            .collection('basicInfo')
            .get()
            .then((value) {
          print(value);
          return value;
        });
        print(fut);
        throw (fut);
      } catch (e) {
        print(e);
        throw (e);
      }
    }

    return Column(
      children: [
        Text("${getTourneyData().then((value) {
          print(value);
        })}"),
        Text("$i"),
      ],
    );
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
    //                   Text(data['game']),
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
    //                   Text("Rs ${basicData['entryFee'].toString()}"),
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
    //                   Text("Rs ${basicData['prizeMoney'].toString()}"),
    //                 ],
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );

    // return FutureBuilder<QuerySnapshot>(
    //     key: ValueKey(widget.tourneyObj.id),
    //     future: fut,
    //     builder: (ctx, snap) {
    //       while (!snap.hasData) {}
    //       return Text(snap.data!.docs
    //           .map((e) => e.data().toString())
    //           .toList()
    //           .toString());
    //     });

    // print(widget.tourneyObj.id.toString());
    // return StreamBuilder<QuerySnapshot>(
    //     key: ValueKey(widget.tourneyObj.id.toString()),
    //     stream: tourneyQuery,
    //     builder: (ctx, AsyncSnapshot<QuerySnapshot> snap) {
    //       if (snap.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       } else {
    //         print(snap.data!.docs.map((e) => e.id));
    //         var gameQuery = FirebaseFirestore.instance
    //             .collection('games')
    //             .doc(snap.data!.docs.map((e) => e.id).toList()[0].trim())
    //             .snapshots();
    //         return StreamBuilder<DocumentSnapshot>(
    //             key: ValueKey(widget.tourneyObj.id.toString()),
    //             stream: gameQuery,
    //             builder: (ctx, gameSnap) {
    //               if (gameSnap.connectionState == ConnectionState.waiting) {
    //                 return Center(
    //                   child: CircularProgressIndicator(),
    //                 );
    //               } else {
    //                 Map<String, dynamic> basicData =
    //                     snap.data!.docs.first.data() as Map<String, dynamic>;

    //                 Map<String, dynamic> data =
    //                     gameSnap.data!.data() as Map<String, dynamic>;

    //     return Padding(
    //       padding: EdgeInsets.all(8),
    //       child: Card(
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Container(
    //               height: 150,
    //               width: 150,
    //               child:
    //                   Image.network(data['url'], fit: BoxFit.fill),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(right: 50),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment:
    //                     MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Row(
    //                     children: [
    //                       Text(
    //                         "Game: ",
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 15),
    //                       ),
    //                       Text(data['game']),
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: 5,
    //                   ),
    //                   Row(
    //                     children: [
    //                       Text(
    //                         "Entry Fee: ",
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 15),
    //                       ),
    //                       Text(
    //                           "Rs ${basicData['entryFee'].toString()}"),
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: 5,
    //                   ),
    //                   Row(
    //                     children: [
    //                       Text(
    //                         "Prize Money: ",
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 15),
    //                       ),
    //                       Text(
    //                           "Rs ${basicData['prizeMoney'].toString()}"),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     );
    //   }
    // });
    //       }
    //     });
  }
}
