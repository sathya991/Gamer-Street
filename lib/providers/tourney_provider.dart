import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      'registrationEndTime': registrationTime,
      'game': 'BGMI',
      'url':
          'https://firebasestorage.googleapis.com/v0/b/gamerstreet-40220.appspot.com/o/games%2Fbgmi.jpg?alt=media&token=2b9d0c31-1162-4aa9-93b4-af4c0ba5b3fe'
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('tournaments')
          .doc(value.parent.parent!.id)
          .set({
        'game': 'BGMI',
        'hostId': FirebaseAuth.instance.currentUser!.uid.toString(),
      }).then((val) async {
        await FirebaseFirestore.instance
            .collection('tournaments')
            .doc(value.parent.parent!.id)
            .collection('additionalInfo')
            .add({'map': map, 'teamMode': teamMode});
      }).then((_) async {
        await FirebaseFirestore.instance
            .collection('tournaments')
            .doc(value.parent.parent!.id)
            .collection('registeredUsers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'host': FirebaseAuth.instance.currentUser!.uid.toString()});
      });
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
      'registrationEndTime': registrationTime,
      'game': 'Ludo King',
      'url':
          'https://firebasestorage.googleapis.com/v0/b/gamerstreet-40220.appspot.com/o/games%2FLudo_King_Logo.jpg?alt=media&token=eeed85e4-aac3-4d53-af9f-a9cb98d9fd7a'
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('tournaments')
          .doc(value.parent.parent!.id)
          .set({
        'game': 'Ludo King',
        'hostId': FirebaseAuth.instance.currentUser!.uid.toString(),
      }).then((val) async {
        await FirebaseFirestore.instance
            .collection('tournaments')
            .doc(value.parent.parent!.id)
            .collection('additionalInfo')
            .add({'noOfPlayers': players});
      }).then((_) async {
        await FirebaseFirestore.instance
            .collection('tournaments')
            .doc(value.parent.parent!.id)
            .collection('registeredUsers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'host': FirebaseAuth.instance.currentUser!.uid.toString()});
      });
    });
  }

  Future getRegisteredUsers(String id) async {
    String hostId = "";
    List registeredId = [];
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .get()
        .then((firstValue) async {
      hostId = firstValue.get('hostId');
    });
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .collection('registeredUsers')
        .get()
        .then((secondValue) async {
      int len = secondValue.docs.length;
      for (int i = 0; i < len; i++) {
        if (hostId == secondValue.docs[i].id) {
          continue;
        }
        registeredId.add(secondValue.docs[i].id);
      }
    });
    for (int i = 0; i < registeredId.length; i++) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(registeredId[i].trim())
          .get()
          .then((value) {
        return value.get('userName');
      });
    }
  }
}
