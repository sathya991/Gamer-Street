import 'package:flutter/material.dart';
import 'package:gamer_street/screens/Gamestournament.dart';
import 'package:gamer_street/screens/HostingGame.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gamer_street/screens/games_screen.dart';
import 'package:shimmer/shimmer.dart';

class GameDetailWidget extends StatefulWidget {
  final String? game;
  final String? gameImageUrl;
  final double? width;
  final bool isHosting;
  const GameDetailWidget(
      {Key? key,
      this.game,
      required this.gameImageUrl,
      this.width,
      required this.isHosting})
      : super(key: key);

  @override
  _GameDetailWidgetState createState() => _GameDetailWidgetState();
}

class _GameDetailWidgetState extends State<GameDetailWidget> {
  buildImage(String? s) {
    return (CachedNetworkImage(
      key: UniqueKey(),
      imageUrl: s!,
      height: (widget.width! / 4) * 2.8,
      maxHeightDiskCache: 240,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: Shimmer.fromColors(
            baseColor: Colors.black,
            highlightColor: Colors.red,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
            )),
      ),
      errorWidget: (context, url, error) => Container(
        alignment: Alignment.center,
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.green,
            ),
            Text(
              "Hey Dude! turn on your Internet, Man.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: widget.width! / 17),
            )
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(15)),
      splashColor: Colors.white,
      onTap: () {
        if (widget.isHosting) {
          Navigator.of(context)
              .pushNamed(HostingGame.Hosting_Game, arguments: widget.game);
        } else {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => GamesTournament("all")));
        }
      },
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(15))),
          elevation: 5,
          child: Stack(
            children: [
              buildImage(widget.gameImageUrl),
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
