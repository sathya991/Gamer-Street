import 'package:flutter/material.dart';
import 'package:gamer_street/screens/Gamestournamet.dart';
import 'package:gamer_street/screens/Gamestournamet.dart';

class GameDetailWidget extends StatefulWidget {
  final String? game;
  final String? gameImageUrl;
  final double? width;
  //const GameDetailWidget({this.game,this.gameImageUrl});
  const GameDetailWidget({Key? key, this.game, this.gameImageUrl, this.width})
      : super(key: key);

  @override
  _GameDetailWidgetState createState() => _GameDetailWidgetState();
}

class _GameDetailWidgetState extends State<GameDetailWidget> {
  //var k=this.Widget.game;
  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(15)),
      splashColor: Colors.white,
      onTap: () {
        Navigator.of(context).pushNamed(GamesTournament.gamesTournamentRoute,
            arguments: widget.game);
      },
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(15))),
          elevation: 5,
          child: Stack(
            children: [
              Image.network(
                widget.gameImageUrl!,
                fit: BoxFit.cover,
                height: (widget.width! / 4) * 2.8,
              ),
              Positioned(
                  bottom: widget.width! / 20,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20)),
                        gradient: LinearGradient(colors: [
                          Colors.black54,
                          Colors.black,
                        ]),
                        color: Colors.black87),
                    padding: EdgeInsets.all(widget.width! / 13),
                    width: (widget.width! / 4) * 2.8,
                    child: Text(
                      widget.game!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: widget.width! / 14,
                          color: Colors.white),
                      overflow: TextOverflow.fade,
                    ),
                  )),
            ],
          )),
    );
  }
}
