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
        height: double.infinity,
        width: double.infinity,
        decoration:
            BoxDecoration(border: Border.all(width: 13, color: Colors.black)),
        child: Container(
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.white, Colors.black54, Colors.black54]),
                border: Border.all(width: 0.2, color: Colors.white)),
            child: Container(
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: [Colors.white, Colors.black54, Colors.black87]),
                  border: Border.all(width: 0.2, color: Colors.white)),
              // color: Colors.white,
              child: Center(
                child: Text(
                  "This is Played list data of all games in Gamer street app",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
