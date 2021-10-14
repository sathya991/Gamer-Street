import 'package:flutter/material.dart';

class GameDetailWidget extends StatefulWidget {
  const GameDetailWidget({Key? key}) : super(key: key);

  @override
  _GameDetailWidgetState createState() => _GameDetailWidgetState();
}

class _GameDetailWidgetState extends State<GameDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue),
      child: Center(
        child: Text(
          "BGMI",
        ),
      ),
    );
  }
}
