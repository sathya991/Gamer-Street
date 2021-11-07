import 'package:flutter/material.dart';
import 'package:gamer_street/screens/tourneyCreationScreen.dart';

class HostingGame extends StatefulWidget {
  const HostingGame({Key? key}) : super(key: key);
  static const Hosting_Game = '/Hosting-Game';
  @override
  _HostingGameState createState() => _HostingGameState();
}

class _HostingGameState extends State<HostingGame> {
  @override
  Widget build(BuildContext context) {
    final gamename = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: TourneyCreationScreen(gameName: gamename),
    );
  }
}
