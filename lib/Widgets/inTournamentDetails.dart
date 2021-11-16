import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/screens/profile.dart';

class InTournamentDetails extends StatefulWidget {
  final tourneyId;
  final gameName;
  const InTournamentDetails(this.tourneyId, this.gameName, {Key? key})
      : super(key: key);

  @override
  State<InTournamentDetails> createState() => _InTournamentDetailsState();
}

class _InTournamentDetailsState extends State<InTournamentDetails> {
  List registeredNames = [];
  String hostId = "";
  var registeredUserStream;
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
    registeredUserStream = FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .collection('registeredUsers')
        .snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRegisteredUsers(widget.tourneyId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: registeredUserStream,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.data!.docs.length == 0) {
            return Center(
              child: Text("No users Registered yet"),
            );
          }
          return Container(
            padding: EdgeInsets.all(10),
            child: widget.gameName == 'Ludo King'
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) {
                      var val = snapshot.data!.docs;
                      Map valMap = val[index].get('players');
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
                              Text(valMap['userName'][0])
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(Profile.profile);
                        },
                      );
                    })
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) {
                      var val = snapshot.data!.docs;
                      Map valMap = val[index].get('players');
                      List userNames = valMap['userName'];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: userNames.length,
                            itemBuilder: (ctx1, index1) {
                              return GestureDetector(
                                key: ValueKey(userNames[index1]),
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
                                      Text(userNames[index1])
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(Profile.profile);
                                },
                              );
                            }),
                      );
                    }),
          );
        });
  }
}
