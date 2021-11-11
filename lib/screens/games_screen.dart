import 'package:flutter/material.dart';

import 'package:gamer_street/Widgets/gameDetailWidget.dart';

import 'dart:async';

import 'package:gamer_street/Widgets/customRefreshIndicator.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:gamer_street/screens/TabsScreenState.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:connectivity/connectivity.dart';
import 'package:shimmer/shimmer.dart';

class GamesScreen extends StatefulWidget {
  final bool isHosting;
  const GamesScreen({Key? key, required this.isHosting}) : super(key: key);
  static const gamesScreenRoute = '/games-screen';

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  var stream = FirebaseFirestore.instance.collection("games").get();

  Future<QuerySnapshot> streamss() {
    refreshkey.currentState?.show();
    //await Future.delayed(Duration(milliseconds: 500));

    return FirebaseFirestore.instance.collection("games").get();

    /* print(stream);

    return (stream as QuerySnapshot);*/
  }

  @override
  void dispose() {
    // _planeController.dispose();
    // _disposeCloudsControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final widgetwidth;

    if (width < 500) {
      widgetwidth = width / 2;
    } else if (width < 700) {
      widgetwidth = width / 3;
    } else if (width < 900) {
      widgetwidth = width / 4;
    } else if (width < 1200)
      widgetwidth = width / 5;
    else
      widgetwidth = width / 6;

    return Scaffold(
        body: FutureBuilder<QuerySnapshot>(
      future: streamss(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          );
          /*Shimmer.fromColors(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  baseColor: Colors.black,
                  highlightColor: Colors.red);*/
        } else {
          final documents = streamSnapshot.data?.docs;
          print(documents!.length);

          return PlaneIndicator(
              child: GridView.builder(
            padding: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 200),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: widgetwidth,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4),
            itemCount: streamSnapshot.data?.docs.length,
            itemBuilder: (ctx, index) {
              return GameDetailWidget(
                game: documents[index]['game'],
                gameImageUrl: documents[index]['url'],
                width: widgetwidth,
                isHosting: widget.isHosting,
              );
            },
          ));
        }
      },
    ));
  }
}
