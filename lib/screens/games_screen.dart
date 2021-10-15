import 'package:flutter/material.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({Key? key}) : super(key: key);
  static const gamesScreenRoute = '/games-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GamerStreet"),
          automaticallyImplyLeading: false,
        ),
        body: Center(child: Container(child: Text("this is GamesScreen"))));
  }
}
