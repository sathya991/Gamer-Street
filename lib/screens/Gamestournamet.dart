import 'package:flutter/material.dart';

class GamesTournament extends StatelessWidget {
  const GamesTournament({Key? key}) : super(key: key);
  static const gamesTournamentRoute = '/gamesTournamentList';

  @override
  Widget build(BuildContext context) {
    final gamename = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(gamename),
      ),
      body: Center(child: Text(gamename)),
    );
  }
}
