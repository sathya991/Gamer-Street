import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/providers/tourney_provider.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TourneySmallDisplay extends StatefulWidget {
  final String tourneyObj;
  final double width;
  TourneySmallDisplay(this.tourneyObj, this.width);
  @override
  State<TourneySmallDisplay> createState() => _TourneySmallDisplayState();
}

class _TourneySmallDisplayState extends State<TourneySmallDisplay> {
  buildImage(String? s) {
    return (CachedNetworkImage(
      key: UniqueKey(),
      imageUrl: s!,
      maxHeightDiskCache: 240,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: Shimmer.fromColors(
            baseColor: Colors.black,
            highlightColor: Colors.red,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
            )),
      ),
      errorWidget: (context, url, error) => Container(
        alignment: Alignment.center,
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.green,
            ),
            Text("Hey Dude! turn on your Internet, Man.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20) // widget.width! / 17),
                )
          ],
        ),
      ),
    ));
  }

  Future<QuerySnapshot> getData() async {
    print(widget.tourneyObj);
    final String documentid = widget.tourneyObj;
    var stream = await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyObj)
        .collection('basicInfo')
        .get();
    //  widget.tourneyObj = '';
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    double width = widget.width;
    return FutureBuilder<QuerySnapshot>(
        future: getData(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black26,
                  strokeWidth: 2,
                ),
              ),
            );
          } else if (snap.hasData) {
            var data = snap.data!.docs.first;
            print(data['entryFee']);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Card(
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: width / 3.4,
                      width: width / 2.4,
                      child:
                          buildImage('https://unsplash.com/photos/fAwtxmVRsds'),
                      // data['url']),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Game: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width / 25),
                              ),
                              Text(
                                'k',
                                // data['game'],
                                style: TextStyle(fontSize: width / 28),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: width / 50,
                          ),
                          Row(
                            children: [
                              Text(
                                "Entry Fee: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width / 25),
                              ),
                              Text(
                                "Rs ${data['entryFee'].toString()}",
                                style: TextStyle(fontSize: width / 28),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: width / 50,
                          ),
                          Row(
                            children: [
                              Text(
                                "Prize Money: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width / 25),
                              ),
                              Text(
                                "Rs ${data['prizeMoney'].toString()}",
                                style: TextStyle(fontSize: width / 28),
                              ),
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
            return Center(child: Text("No tourneys Registred!"));
          }
        });
  }
}
