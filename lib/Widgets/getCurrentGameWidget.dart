import 'package:flutter/material.dart';

import 'package:gamer_street/screens/bgmiAdditionalInfoScreen.dart';
import 'package:gamer_street/screens/ludoAdditionalInfoScreen.dart';

class GetCurrentGame extends StatelessWidget {
  final gameName;
  final prizeMoney;
  final entryFee;
  final DateTime gameTime;
  final DateTime registrationEndtime;
  const GetCurrentGame(
      {Key? key,
      required this.gameName,
      required this.entryFee,
      required this.gameTime,
      required this.prizeMoney,
      required this.registrationEndtime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (gameName == "BGMI") {
      return BGMIAdditionalInfo(
          prizeMoney, entryFee, gameTime, registrationEndtime);
    } else {
      return LudoKingAdditionalInfo(
          prizeMoney, entryFee, gameTime, registrationEndtime);
    }
  }
}
