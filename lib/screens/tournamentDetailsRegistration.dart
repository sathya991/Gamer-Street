import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TournamentDetailsRegistration extends StatefulWidget {
  const TournamentDetailsRegistration({Key? key}) : super(key: key);
  static const tournamentDetailsRegistration =
      '/tournamentDetailsRegistration-widget';

  @override
  _TournamentDetailsRegistrationState createState() =>
      _TournamentDetailsRegistrationState();
}

class _TournamentDetailsRegistrationState
    extends State<TournamentDetailsRegistration> {
  @override
  Widget build(BuildContext context) {
    List Players = [];
    List l = ModalRoute.of(context)!.settings.arguments as List;
    String tId = l[2];

    Map<String, dynamic> m = {
      "userName": "",
      l[0] + 'id': "id",
      'phone': "",
      'email': "",
      "player": "",
    };

    Future<void> add() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;

        await FirebaseFirestore.instance
            .collection('tournaments')
            .doc(tId)
            .collection('registeredUsers')
            .doc()
            .set({
          "players": {
            "userName": ["sasi", "gopi", "varna", "what"],
            l[0] + 'id': ["89790", "iggdia", "iugshdi", "louahd"],
            'phone': [data['phone'], "898794879", "987529", "984257957"],
            'email': [],
            "player": [FirebaseAuth.instance.currentUser!.uid],
          },
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('PlayerGames')
            .doc()
            .set({"Tid": tId});
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l[0] + ' Registration'),
      ),
      body: Container(
        child: TextButton(
            onPressed: () {
              add();
            },
            child: Text('pay')),
      ),
    );
  }
}
