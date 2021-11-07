import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/bgmiAdditionalInfo.dart';
import 'package:gamer_street/Widgets/ludoKingAdditionalInfo.dart';

class GetCurrentGame extends StatelessWidget {
  final gameName;
  const GetCurrentGame({Key? key, this.gameName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (gameName == "BGMI") {
      return BGMIAdditionalInfo();
    } else {
      return LudoKingAdditionalInfo();
    }
  }
}
