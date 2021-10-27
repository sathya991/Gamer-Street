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
  TourneySmallDisplay(this.tourneyObj);
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
    return FutureBuilder<QuerySnapshot>(
        future: getData(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return LoadingRotating.square(
              borderColor: Colors.black,
              size: 20,
            );
          } else if (snap.hasData) {
            var data = snap.data!.docs.first;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Card(
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 110,
                      width: 150,
                      child: buildImage(data['url']),
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
