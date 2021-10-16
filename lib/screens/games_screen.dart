import 'package:flutter/material.dart';

import 'package:gamer_street/Widgets/gameDetailWidget.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:gamer_street/screens/TabsScreenState.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:connectivity/connectivity.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);
  static const gamesScreenRoute = '/games-screen';

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("games").snapshots(),
      builder: (ctx, streamSnapshot) {
        final documents = streamSnapshot.data?.docs;
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (streamSnapshot.hasData) {
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: width / 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4),
            itemCount: streamSnapshot.data?.docs.length,
            itemBuilder: (ctx, index) {
              return GameDetailWidget(
                game: documents![index]['game'],
                gameImageUrl: documents[index]['url'],
                width: width / 2,
              );
            },
          );
        }
        return (Center(child: Text("nodata")));
      },
    ));
  }
}
