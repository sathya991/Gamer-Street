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

  Future basicInfoAddition(int entryFee, int prizeMoney, DateTime tourneyTime,
      DateTime registrationTime, String gameName, String url) async {
    Future returnVal = (FirebaseFirestore.instance
        .collection('tournaments')
        .doc()
        .collection('basicInfo')
        .add({
      'entryFee': entryFee,
      'prizeMoney': prizeMoney,
      'tourneyTime': tourneyTime,
      'registrationEndTime': registrationTime,
      'game': gameName,
      'url': url,
    }));
    // returnVal.then((value) async {
    //   await FirebaseFirestore.instance
    //       .collection('tournaments')
    //       .doc(value.parent.parent!.id)
    //       .collection('winners')
    //       .doc()
    //       .set({
    //     'winnerOne': "",
    //     'winnerOneSS': "",
    //     'winnerTwo': "",
    //     'winnerTwoSS': "",
    //     'winnerThree': "",
    //     'winnerThreeSS': "",
    //   });
    // });
    return returnVal;
  }

  Future addIntoHosterGames(dynamic value) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('HosterGames')
        .doc()
        .set({
      'Tid': value.parent.parent!.id,
    });
  }

  Future createBgmiTourney(
      int entryFee,
      int prizeMoney,
      DateTime tourneyTime,
      DateTime registrationTime,
      String map,
      String teamMode,
      int noOfWinners) async {
    String url =
        'https://firebasestorage.googleapis.com/v0/b/gamerstreet-40220.appspot.com/o/games%2Fbgmi.jpg?alt=media&token=2b9d0c31-1162-4aa9-93b4-af4c0ba5b3fe';
    basicInfoAddition(
            entryFee, prizeMoney, tourneyTime, registrationTime, "BGMI", url)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('tournaments')
          .doc(value.parent.parent!.id)
          .set({
        'matchState': "inProgress",
        'game': 'BGMI',
        'hostId': FirebaseAuth.instance.currentUser!.uid.toString(),
        'count': teamsCount(teamMode),
      }).then((val) async {
        await FirebaseFirestore.instance
            .collection('tournaments')
            .doc(value.parent.parent!.id)
            .collection('additionalInfo')
            .add(
                {'map': map, 'teamMode': teamMode, 'noOfWinners': noOfWinners});
      });
      addIntoHosterGames(value);
    });
  }

  Future createLudoTourney(int entryFee, int prizeMoney, DateTime tourneyTime,
      DateTime registrationTime, int? players) async {
    String url =
        'https://firebasestorage.googleapis.com/v0/b/gamerstreet-40220.appspot.com/o/games%2FLudo_King_Logo.jpg?alt=media&token=eeed85e4-aac3-4d53-af9f-a9cb98d9fd7a';

    basicInfoAddition(entryFee, prizeMoney, tourneyTime, registrationTime,
            "Ludo King", url)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('tournaments')
          .doc(value.parent.parent!.id)
          .set({
        'matchState': "inProgress",
        'game': 'Ludo King',
        'hostId': FirebaseAuth.instance.currentUser!.uid.toString(),
        'count': players
      }).then((val) async {
        await FirebaseFirestore.instance
            .collection('tournaments')
            .doc(value.parent.parent!.id)
            .collection('additionalInfo')
            .add({'noOfPlayers': players, 'noOfWinners': 1});
      });
      addIntoHosterGames(value);
    });
  }

  setWinner(
      String id, String winnerField, String uid, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .collection('winners')
        .get()
        .then((value) async {
      if (value.docs.length == 1) {
        if (value.docs.first.data().containsKey(winnerField)) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("This position has already been set")));
        } else {
          if (!value.docs.first.data().containsValue(uid)) {
            await FirebaseFirestore.instance
                .collection('tournaments')
                .doc(id)
                .collection('winners')
                .doc(value.docs.first.id)
                .update({winnerField: uid});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text("This player position has already been updated")));
          }
        }
      } else {
        await FirebaseFirestore.instance
            .collection('tournaments')
            .doc(id)
            .collection('winners')
            .doc()
            .set({winnerField: uid});
      }
    });
  }

  int teamsCount(String txt) {
    if (txt == 'Squad') {
      return 25;
    } else if (txt == 'Duo') {
      return 50;
    } else {
      return 100;
    }
  }
}
