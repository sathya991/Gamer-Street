import 'package:flutter/material.dart';
import 'package:gamer_street/providers/tourney_provider.dart';
import 'package:gamer_street/screens/Gamestournament.dart';
import 'package:gamer_street/screens/TabsScreenState.dart';
import 'package:provider/provider.dart';

class BGMIAdditionalInfo extends StatefulWidget {
  final prizeMoney;
  final entryFee;
  final DateTime gameTime;
  final DateTime registrationEndtime;
  const BGMIAdditionalInfo(
      this.prizeMoney, this.entryFee, this.gameTime, this.registrationEndtime,
      {Key? key})
      : super(key: key);
  static const String bgmiScreenRoute = '/bgmi-screen-route';

  @override
  State<BGMIAdditionalInfo> createState() => _BGMIAdditionalInfoState();
}

class _BGMIAdditionalInfoState extends State<BGMIAdditionalInfo> {
  String? teamModeValue;
  String? mapValue;
  int? winCountValue;
  @override
  Widget build(BuildContext context) {
    List teamModes = ['Solo', 'Duo', 'Squad'];
    List maps = ['Erangel', 'Miramar', 'Sanhok', 'Livik', 'Karakin'];
    List winCount = [1, 2, 3];
    return Scaffold(
      appBar: AppBar(title: Text("BGMI")),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
            child: Column(
          children: [
            DropdownButton(
                isExpanded: true,
                value: teamModeValue,
                items: teamModes.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      child: Text(val),
                      value: val,
                    );
                  },
                ).toList(),
                onChanged: (String? val) {
                  setState(() {
                    teamModeValue = val!;
                  });
                },
                hint: Text("Choose Team Size"),
                icon: Icon(Icons.arrow_drop_down_circle)),
            DropdownButton(
                isExpanded: true,
                value: mapValue,
                items: maps.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      child: Text(val),
                      value: val,
                    );
                  },
                ).toList(),
                onChanged: (String? val) {
                  setState(() {
                    mapValue = val!;
                  });
                },
                hint: Text("Choose Map"),
                icon: Icon(Icons.arrow_drop_down_circle)),
            DropdownButton(
                isExpanded: true,
                value: winCountValue,
                items: winCount.map(
                  (val) {
                    return DropdownMenuItem<int>(
                      child: Text(val.toString()),
                      value: val,
                    );
                  },
                ).toList(),
                onChanged: (int? val) {
                  setState(() {
                    winCountValue = val!;
                  });
                },
                hint: Text("Choose No. of Winners"),
                icon: Icon(Icons.arrow_drop_down_circle)),
            ElevatedButton(
                onPressed: () {
                  Provider.of<TourneyProvider>(context, listen: false)
                      .createBgmiTourney(
                    widget.entryFee,
                    widget.prizeMoney,
                    widget.gameTime,
                    widget.registrationEndtime,
                    mapValue!,
                    teamModeValue!,
                    winCountValue!,
                  );
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
