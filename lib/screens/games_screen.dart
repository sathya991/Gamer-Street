import 'package:flutter/material.dart';

import 'package:gamer_street/Widgets/gameDetailWidget.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({Key? key}) : super(key: key);
  static const gamesScreenRoute = '/games-screen';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: GridView.builder(
            padding: EdgeInsets.all(2),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: width / 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2),
            itemBuilder: (ctx, index) {
              return GameDetailWidget();
            }));
  }
}
