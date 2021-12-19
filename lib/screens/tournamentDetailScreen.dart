import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/inTournamentChat.dart';
import 'package:gamer_street/Widgets/inTournamentDetails.dart';
import 'package:gamer_street/Widgets/tournamentDetails.dart';

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
  var hostId;
  var matchState;
  var isHost;
  var noOfWinners = 0;
  Future getHostId(String id) async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .get()
        .then((firstValue) async {
      setState(() {
        hostId = firstValue.get('hostId');
        matchState = firstValue.get('matchState');
        isHost = FirebaseAuth.instance.currentUser!.uid == hostId;
      });
    });
  }

  Future getWinnerNo(String id) async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .collection('additionalInfo')
        .get()
        .then((value) {
      setState(() {
        noOfWinners = value.docs.first.get('noOfWinners');
      });
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
    getHostId(widget.tourneyId);
    getWinnerNo(widget.tourneyId);
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(_handleSelected);
  }

  @override
  Widget build(BuildContext context) {
    _widgets = [
      TournamentDetails(
        tId: widget.tourneyId,
      ),
      InTournamentDetails(widget.tourneyId, widget.gameName, hostId, matchState,
          isHost, noOfWinners),
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
