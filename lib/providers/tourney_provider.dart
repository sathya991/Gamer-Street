import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TourneyProvider extends ChangeNotifier {
  Future getTourneyData(String id) async {
    return await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .collection('basicInfo')
        .get();
  }

  String? prizeMoneyValidator(String? val) {
    if (val!.isEmpty) {
      return "Please enter a Prize Money";
    }
    if (int.tryParse(val)! <= 0) {
      return "Please add valid Prize Amount";
    }
    return null;
  }

  String? entryFeeValidator(String? val) {
    if (val!.isEmpty) {
      return "Please enter a Entry Fee";
    }
    if (int.tryParse(val)! <= 0) {
      return "Please add valid Entry Fee";
    }
    return null;
  }

  Future createBgmiTourney(int entryFee, int prizeMoney, DateTime tourneyTime,
      DateTime registrationTime, String map, String teamMode) async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc()
        .collection('basicInfo')
        .add({
      'entryFee': entryFee,
      'prizeMoney': prizeMoney,
      'tourneyTime': tourneyTime,
      'registrationEndTime': registrationTime
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('tournaments')
          .doc(value.parent.parent!.id)
          .collection('additionalInfo')
          .add({'map': map, 'teamMode': teamMode});
    });
  }

  Future createLudoTourney(int entryFee, int prizeMoney, DateTime tourneyTime,
      DateTime registrationTime, int? players) async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc()
        .collection('basicInfo')
        .add({
      'entryFee': entryFee,
      'prizeMoney': prizeMoney,
      'tourneyTime': tourneyTime,
      'registrationEndTime': registrationTime
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('tournaments')
          .doc(value.parent.parent!.id)
          .collection('additionalInfo')
          .add({'noOfPlayers': players});
    });
  }
}
