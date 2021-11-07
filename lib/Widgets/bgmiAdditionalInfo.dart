import 'package:flutter/material.dart';

class BGMIAdditionalInfo extends StatefulWidget {
  const BGMIAdditionalInfo({Key? key}) : super(key: key);

  @override
  State<BGMIAdditionalInfo> createState() => _BGMIAdditionalInfoState();
}

class _BGMIAdditionalInfoState extends State<BGMIAdditionalInfo> {
  String? _teamModeValue;
  String? _mapValue;
  @override
  Widget build(BuildContext context) {
    List teamModes = ['Solo', 'Duo', 'Squad'];
    List maps = ['Erangel', 'Miramar', 'Sanhok', 'Livik', 'Karakin'];
    return Form(
        child: Column(
      children: [
        DropdownButton(
            isExpanded: true,
            value: _teamModeValue,
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
                _teamModeValue = val!;
              });
            },
            hint: Text("Choose Team Size"),
            icon: Icon(Icons.arrow_drop_down_circle)),
        DropdownButton(
            isExpanded: true,
            value: _mapValue,
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
                _mapValue = val!;
              });
            },
            hint: Text("Choose Map"),
            icon: Icon(Icons.arrow_drop_down_circle))
      ],
    ));
  }
}
