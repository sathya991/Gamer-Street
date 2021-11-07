import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/getCurrentGameWidget.dart';
import 'package:gamer_street/providers/tourney_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TourneyBasicDetail extends StatefulWidget {
  final gameName;
  const TourneyBasicDetail({Key? key, this.gameName}) : super(key: key);

  @override
  State<TourneyBasicDetail> createState() => _TourneyBasicDetailState();
}

class _TourneyBasicDetailState extends State<TourneyBasicDetail> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  int prizeMoney = 0;
  int entryFee = 0;
  DateTime tourneyDateTime = DateTime.now();
  DateTime registerDateTime = DateTime.now();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  Future createTourney() async {}
  String getTourneyText() {
    return DateFormat('dd/MM/yyyy HH:mm').format(tourneyDateTime);
  }

  String getRegisterText() {
    return DateFormat('dd/MM/yyyy HH:mm').format(registerDateTime);
  }

  validateAndPush() {
    if (registerDateTime.isAfter(tourneyDateTime) ||
        registerDateTime.isAtSameMomentAs(tourneyDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Starting time should not be before or at the time of registration ending time")));
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => GetCurrentGame(
                gameName: widget.gameName,
                prizeMoney: prizeMoney,
                entryFee: entryFee,
                gameTime: tourneyDateTime,
                registrationEndtime: registerDateTime,
              )));
    }
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
    final provider = Provider.of<TourneyProvider>(context);
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Entry Fee"),
                keyboardType: TextInputType.number,
                validator: (val) => provider.entryFeeValidator(val),
                onSaved: (tx) {
                  entryFee = int.tryParse(tx!)!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Prize Money"),
                keyboardType: TextInputType.number,
                validator: (val) => provider.prizeMoneyValidator(val),
                onSaved: (tx) {
                  prizeMoney = int.tryParse(tx!)!;
                },
              ),
            ],
          ),
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
        ElevatedButton(
            onPressed: () {
              validateAndPush();
            },
            child: Text("Add Additional Info")),
      ],
    );
  }
}
