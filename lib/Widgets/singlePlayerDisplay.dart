import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:gamer_street/providers/tourney_provider.dart';
import 'package:gamer_street/screens/profile.dart';
import 'package:provider/provider.dart';

class SinglePlayerDisplay extends StatefulWidget {
  final snapshot;
  final isHost;
  final noOfWinners;
  final matchState;
  final tourneyId;
  const SinglePlayerDisplay(
      {this.snapshot,
      this.isHost,
      this.noOfWinners,
      this.matchState,
      this.tourneyId,
      Key? key})
      : super(key: key);

  @override
  _SinglePlayerDisplayState createState() => _SinglePlayerDisplayState();
}

class _SinglePlayerDisplayState extends State<SinglePlayerDisplay> {
  var curPlayerId;
  late List<FocusedMenuItem> items;
  List<FocusedMenuItem> menuItemsList = [];
  @override
  void initState() {
    final tourneyProvider =
        Provider.of<TourneyProvider>(context, listen: false);
    items = [
      FocusedMenuItem(
          title: Text("Winner"),
          onPressed: () {
            tourneyProvider.setWinner(
                widget.tourneyId, "winnerOne", curPlayerId, context);
          }),
      FocusedMenuItem(
          title: Text("Second Place"),
          onPressed: () {
            tourneyProvider.setWinner(
                widget.tourneyId, "winnerTwo", curPlayerId, context);
          }),
      FocusedMenuItem(
          title: Text("Third Place"),
          onPressed: () {
            tourneyProvider.setWinner(
                widget.tourneyId, "winnerThree", curPlayerId, context);
          }),
    ];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.matchState != 'inProgress') {
      for (int i = 0; i < widget.noOfWinners; i++) {
        menuItemsList.add(items[i]);
      }
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.snapshot.data!.docs.length,
        itemBuilder: (ctx, index) {
          var val = widget.snapshot.data!.docs;
          Map valMap = val[index].get('players');
          return FocusedMenuHolder(
            menuWidth: MediaQuery.of(context).size.width * 0.50,
            blurSize: 5.0,
            menuItemExtent: 45,
            menuBoxDecoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            duration: Duration(milliseconds: 100),
            animateMenuItems: true,
            blurBackgroundColor: Colors.black54,
            openWithTap: true,
            menuOffset: 10.0,
            bottomOffsetHeight: 80.0,
            onPressed: () {
              setState(() {
                curPlayerId = valMap['playerDocId'][0];
              });
            },
            menuItems: [
                  FocusedMenuItem(
                      title: Text("View Profile"),
                      onPressed: () {
                        curPlayerId = valMap['playerDocId'][0];
                        Navigator.of(context).pushNamed(Profile.profile,
                            arguments: valMap['playerDocId'][0]);
                      }),
                ] +
                menuItemsList,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: valMap['profileUrl'][0].toString().isEmpty
                        ? NetworkImage(
                            "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png")
                        : NetworkImage(valMap['profileUrl'][0]),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(valMap['userName'][0])
                ],
              ),
            ),
          );
        });
  }
}
