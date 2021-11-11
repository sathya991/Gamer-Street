import 'package:flutter/material.dart';
import 'package:gamer_street/providers/tourney_provider.dart';
import 'package:provider/provider.dart';

import 'TabsScreenState.dart';

class LudoKingAdditionalInfo extends StatefulWidget {
  final prizeMoney;
  final entryFee;
  final DateTime gameTime;
  final DateTime registrationEndtime;
  const LudoKingAdditionalInfo(
      this.prizeMoney, this.entryFee, this.gameTime, this.registrationEndtime,
      {Key? key})
      : super(key: key);
  static const String ludoScreenRoute = '/ludo-screen-route';
  @override
  State<LudoKingAdditionalInfo> createState() => _LudoKingAdditionalInfoState();
}

class _LudoKingAdditionalInfoState extends State<LudoKingAdditionalInfo> {
  int? _numberOfPlayers;
  @override
  Widget build(BuildContext context) {
    List numberOfPlayers = [2, 3, 4];
    return Scaffold(
      appBar: AppBar(title: Text("Ludo King")),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
            child: Column(
          children: [
            DropdownButton(
                isExpanded: true,
                value: _numberOfPlayers,
                items: numberOfPlayers.map(
                  (val) {
                    return DropdownMenuItem<int>(
                      child: Text(val.toString()),
                      value: val,
                    );
                  },
                ).toList(),
                onChanged: (int? val) {
                  setState(() {
                    _numberOfPlayers = val!;
                  });
                },
                hint: Text("Number of Players"),
                icon: Icon(Icons.arrow_drop_down_circle)),
            ElevatedButton(
                onPressed: () {
                  Provider.of<TourneyProvider>(context, listen: false)
                      .createLudoTourney(
                          widget.entryFee,
                          widget.prizeMoney,
                          widget.gameTime,
                          widget.registrationEndtime,
                          _numberOfPlayers);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    TabsScreenState.tabsRouteName,
                    (route) => false,
                  );
                },
                child: Text("Create Tournament")),
          ],
        )),
      ),
    );
  }
}
