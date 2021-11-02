import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text("Host $gamename",
            style: TextStyle(fontWeight: FontWeight.w300)),
      ),
      body: Center(child: Text(gamename)),
    );
  }
}
