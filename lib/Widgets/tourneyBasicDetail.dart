import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef basicInfoCallback = void Function(int entryFee, int prizeMoney,
    DateTime gameTime, DateTime registrationEndTime);

class TourneyBasicDetail extends StatefulWidget {
  const TourneyBasicDetail({Key? key}) : super(key: key);

  @override
  State<TourneyBasicDetail> createState() => _TourneyBasicDetailState();
}

class _TourneyBasicDetailState extends State<TourneyBasicDetail> {
  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  late double _height;
  late double _width;
  DateTime tourneyDateTime = DateTime.now();
  DateTime compareTourneyDateTime = DateTime.now();
  DateTime registerDateTime = DateTime.now();
  DateTime compareRegisterDateTime = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  Future createTourney() async {}
  String getTourneyText() {
    return DateFormat('MM/dd/yyyy HH:mm').format(tourneyDateTime);
  }

  String getRegisterText() {
    return DateFormat('MM/dd/yyyy HH:mm').format(registerDateTime);
  }

  Future tourneyDateTimePicker(BuildContext context) async {
    final date = await _selectDate(context);
    if (date == null) return;
    final time = await _selectTime(context);
    if (time == null) return;
    setState(() {
      tourneyDateTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  Future registerEndDateTimePicker(BuildContext context) async {
    final date = await _selectDate(context);
    if (date == null) return;
    final time = await _selectTime(context);
    if (time == null) return;
    setState(() {
      registerDateTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2023));
    if (picked == null) {
      return null;
    }
    return picked;
  }

  Future _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked == null) {
      return null;
    }
    return picked;
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Entry Fee"),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Prize Money"),
            keyboardType: TextInputType.number,
          ),
          TextButton(
              onPressed: () {
                tourneyDateTimePicker(context);
              },
              child: Row(
                children: [
                  Text(
                    "Tournament Date and Time: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(getTourneyText()),
                ],
              )),
          TextButton(
              onPressed: () {
                registerEndDateTimePicker(context);
              },
              child: Row(
                children: [
                  Text(
                    "Registration ends at: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(getRegisterText()),
                ],
              )),
        ],
      ),
    );
  }
}
