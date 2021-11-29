import 'package:flutter/material.dart';
import 'package:gamer_street/screens/games_screen.dart';

class Hosting extends StatefulWidget {
  const Hosting({Key? key}) : super(key: key);
  static const HostingRoute = '/Hosting-games';

  @override
  _HostingState createState() => _HostingState();
}

class _HostingState extends State<Hosting> {
  func(val, val2) {}
  @override
  Widget build(BuildContext context) {
    final _isHosting = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Host Tournaments',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: GamesScreen(
        isHosting: _isHosting,
        func: func,
      ),
    );
  }
}
