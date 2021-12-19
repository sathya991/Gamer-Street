import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/inTournamentChat.dart';
import 'package:gamer_street/Widgets/inTournamentDetails.dart';
import 'package:gamer_street/Widgets/tournamentDetails.dart';
import 'package:gamer_street/Widgets/Screenshots.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TournamentDetailScreen extends StatefulWidget {
  static const String tournamentDetailScreenRoute = '/tournament-detail-screen';
  final tourneyId;
  final gameName;
  const TournamentDetailScreen(this.tourneyId, this.gameName, {Key? key})
      : super(key: key);

  @override
  _TournamentDetailScreenState createState() => _TournamentDetailScreenState();
}

class _TournamentDetailScreenState extends State<TournamentDetailScreen>
    with TickerProviderStateMixin {
  String mState = '';

  void mtState() async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyId)
        .get()
        .then((value) {
      setState(() {
        mState = value.get('matchState');
      });
    });
  }

  void changeWidget() async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyId)
        .update({"matchState": "completed"});

    setState(() {
      mState = "completed";
    });
  }

  List<Widget> _widgets = [];
  late TabController _tabController;
  int index = 0;
  List<String> appBarNames = ["Details", "Registered Players", "Chat"];
  String appBarName = "GamerStreet";
  void _handleSelected() {
    setState(() {
      appBarName = appBarNames[_tabController.index];
    });
  }

  @override
  void initState() {
    super.initState();
    mtState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(_handleSelected);
  }

  @override
  Widget build(BuildContext context) {
    _widgets = [
      TournamentDetails(
        tId: widget.tourneyId,
      ),
      mState == ""
          ? Container(
              child: CircularProgressIndicator(),
            )
          : mState == "inProgress"
              ? InTournamentDetails(
                  gameName: widget.gameName,
                  tourneyId: widget.tourneyId,
                  fun: changeWidget,
                )
              : Screenshots(),
      InTournamentChat(widget.tourneyId)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarName),
        bottom: new TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.details_rounded),
              text: appBarNames[0],
            ),
            Tab(
              icon: Icon(Icons.verified_user),
              text: appBarNames[1],
            ),
            Tab(
              icon: Icon(Icons.chat),
              text: appBarNames[2],
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: _widgets),
    );
  }
}
