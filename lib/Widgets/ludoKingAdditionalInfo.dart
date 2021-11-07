import 'package:flutter/material.dart';

class LudoKingAdditionalInfo extends StatefulWidget {
  const LudoKingAdditionalInfo({Key? key}) : super(key: key);

  @override
  State<LudoKingAdditionalInfo> createState() => _LudoKingAdditionalInfoState();
}

class _LudoKingAdditionalInfoState extends State<LudoKingAdditionalInfo> {
  int? _numberOfPlayers;
  @override
  Widget build(BuildContext context) {
    List numberOfPlayers = [2, 3, 4];
    return Form(
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
      ],
    ));
  }
}
