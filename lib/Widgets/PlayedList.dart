import 'package:flutter/material.dart';

class PlayedList extends StatefulWidget {
  const PlayedList({Key? key}) : super(key: key);

  @override
  _PlayedListState createState() => _PlayedListState();
}

class _PlayedListState extends State<PlayedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.white)),
          // color: Colors.white,
          child: Center(
            child: Text(
              "This is Played list data of all games in Gamer street app",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
