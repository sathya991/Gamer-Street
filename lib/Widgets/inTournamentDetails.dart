import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/screens/profile.dart';

class InTournamentDetails extends StatefulWidget {
  final tourneyId;
  const InTournamentDetails(this.tourneyId, {Key? key}) : super(key: key);

  @override
  State<InTournamentDetails> createState() => _InTournamentDetailsState();
}

class _InTournamentDetailsState extends State<InTournamentDetails> {
  List registeredNames = [];
  String hostId = "";
  Future getHostId(String id) async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .get()
        .then((firstValue) async {
      hostId = firstValue.get('hostId');
    });
  }

  getRegisteredUsers(String id) {
    getHostId(id);
    return FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .collection('registeredUsers')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getRegisteredUsers(widget.tourneyId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          // return Text(snapshot.data!.docs.first.id);
          return Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) {
                  var val = snapshot.data!.docs;
                  return GestureDetector(
                    key: ValueKey(val[index].id),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png"),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(val[index].get('userName'))
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(Profile.profile);
                    },
                  );
                }),
          );
        });
  }
}
