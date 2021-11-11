import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/tourneyBasicDetail.dart';

class TourneyCreationScreen extends StatefulWidget {
  final gameName;
  const TourneyCreationScreen({Key? key, @required this.gameName})
      : super(key: key);

  @override
  _TourneyCreationScreenState createState() => _TourneyCreationScreenState();
}

class _TourneyCreationScreenState extends State<TourneyCreationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create tournament"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TourneyBasicDetail(gameName: widget.gameName),
            ],
          ),
        ),
      ),
    );
  }
}
