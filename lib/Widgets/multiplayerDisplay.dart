import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:gamer_street/screens/profile.dart';

class MultiPlayerDisplay extends StatefulWidget {
  final snapshot;
  final isHost;
  final noOfWinners;
  final matchState;
  final tourneyId;
  const MultiPlayerDisplay(
      {this.snapshot,
      this.isHost,
      this.noOfWinners,
      this.matchState,
      this.tourneyId,
      Key? key})
      : super(key: key);

  @override
  _MultiPlayerDisplayState createState() => _MultiPlayerDisplayState();
}

class _MultiPlayerDisplayState extends State<MultiPlayerDisplay> {
  var curPlayerId;
  late List<FocusedMenuItem> items;
  List<FocusedMenuItem> menuItemsList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateWinner(String winnerPlace) {
      return FirebaseFirestore.instance
          .collection('tournaments')
          .doc(widget.tourneyId)
          .collection('winners')
          .get()
          .then((value) {
        value.docs.first.data().update(winnerPlace, (value) => curPlayerId);
      });
    }

    items = [
      FocusedMenuItem(
          title: Text("Winner"),
          onPressed: () {
            updateWinner("winnerOne");
          }),
      FocusedMenuItem(
          title: Text("Second Place"),
          onPressed: () {
            updateWinner("winnerTwo");
          }),
      FocusedMenuItem(
          title: Text("Third Place"),
          onPressed: () {
            updateWinner("winnerThree");
          }),
    ];
    if (widget.matchState != 'inProgress') {
      for (int i = 0; i < widget.noOfWinners; i++) {
        menuItemsList.add(items[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.snapshot.data!.docs.length,
        itemBuilder: (ctx, index) {
          var val = widget.snapshot.data!.docs;
          Map valMap = val[index].get('players');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: valMap['email'].length,
                itemBuilder: (ctx1, index1) {
                  return menuPopup(valMap, index1, cardShow(valMap, index1));
                }),
          );
        });
  }

  Widget cardShow(valMap, index1) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: valMap['profileUrl'][index1].toString().isEmpty
                ? NetworkImage(
                    "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png")
                : NetworkImage(valMap['profileUrl'][index1]),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            width: 20,
          ),
          Text(valMap['userName'][index1])
        ],
      ),
    );
  }

  Widget menuPopup(valMap, index1, child) {
    if (index1 != 0) {
      menuItemsList = [];
    }
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
        onPressed: () {},
        menuItems: [
              FocusedMenuItem(
                  title: Text("View Profile"),
                  onPressed: () {
                    setState(() {
                      curPlayerId = valMap['playerDocId'][index1];
                    });
                    Navigator.of(context).pushNamed(Profile.profile,
                        arguments: valMap['playerDocId'][index1]);
                  }),
            ] +
            menuItemsList,
        child: child);
  }
}
