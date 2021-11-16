import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TournamentDetailsRegistration extends StatefulWidget {
  final int teamSize;
  final String game;
  final String tId;
  final String hostId;
  const TournamentDetailsRegistration(
      {Key? key,
      required this.game,
      required this.teamSize,
      required this.tId,
      required this.hostId})
      : super(key: key);
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
    Future<QuerySnapshot> getUsers() async {
      return await FirebaseFirestore.instance.collection('users').get();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.game + ' Registration'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: FutureBuilder<QuerySnapshot>(
                future: getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 6,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    var docs = snapshot.data!.docs;
                    return UsersRegistration(
                      docs: docs,
                      game: widget.game,
                      teamSize: widget.teamSize,
                      tId: widget.tId,
                      hostId: widget.hostId,
                    );
                  } else {
                    return Center(
                      child: Text("No users found"),
                    );
                  }
                }),
          ),
        ));
  }
}

class UsersRegistration extends StatefulWidget {
  final int teamSize;
  final String game;
  final String tId;
  final String hostId;
  final List<QueryDocumentSnapshot<Object?>> docs;
  const UsersRegistration(
      {Key? key,
      required this.docs,
      required this.game,
      required this.teamSize,
      required this.hostId,
      required this.tId})
      : super(key: key);

  @override
  _UsersRegistrationState createState() => _UsersRegistrationState();
}

class _UsersRegistrationState extends State<UsersRegistration> {
  final _formKey = GlobalKey<FormState>();
  List<String> userName = [];
  List<String> docId = [];
  List<String> phone = [];
  List<String> email = [];
  List<String> gameId = [];
  List<String> profileUrl = [];
//  bool _focusBool = true;
  List<bool> _focusBool = [];
  void intiliazeData() {
    if (widget.teamSize == 1) {
      userName.add("Add Player");
      docId.add('no');
      phone.add('no');
      email.add('no');
      gameId.add('');
      profileUrl.add("");
      _focusBool.add(false);
    } else {
      for (int i = 0; i < widget.teamSize; i++) {
        docId.add('no');
        userName.add("Add Player ${(i + 1)}");
        phone.add('no');
        email.add('no');
        gameId.add('');
        profileUrl.add("");
        _focusBool.add(false);
      }
    }
  }

  FToast fToast = FToast();

  void initState() {
    intiliazeData();
    super.initState();
    FToast fToast;
    fToast = FToast();
    fToast.init(context);
  }

  bool buildvalue = true;
  void setbuildvalue() {
    buildvalue = false;
  }

  void updateList(
      String uName, String dId, String pe, String em, int index, String pUrl) {
    setState(() {
      userName[index] = uName;
      phone[index] = pe;
      email[index] = em;
      docId[index] = dId;
      profileUrl[index] = pUrl;
    });
  }

  Future<void> add() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;

      await FirebaseFirestore.instance
          .collection('tournaments')
          .doc(widget.tId)
          .collection('registeredUsers')
          .doc()
          .set({
        "players": {
          "userName": userName,
          'gameId': gameId,
          'phone': phone,
          'email': email,
          "playerDocId": docId,
          "profileUrl": profileUrl,
        },
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('PlayerGames')
          .doc()
          .set({"Tid": widget.tId});
    });
  }

  @override
  Widget build(BuildContext context) {
    int playerIndex = -1;

    Widget playersWidget(
        String userName, int i, List<QueryDocumentSnapshot<Object?>> dId) {
      return Card(
        elevation: 10,
        child: ListTile(
          onTap: () {
            setState(() {
              _focusBool[i] = true;
            });
            showSearch(
                context: context,
                delegate: UserSearch(dId, i, updateList, widget.hostId));
          },
          trailing: Column(
            children: [
              docId[i] == "no"
                  ? Icon(
                      Icons.add,
                      color: Colors.green,
                      size: 35,
                    )
                  : Icon(Icons.videogame_asset)
            ],
          ),
          subtitle: docId[i] == "no"
              ? SizedBox(
                  height: 0,
                  width: 0,
                )
              : Container(
                  height: 78,
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    initialValue: gameId[i],
                    onSaved: (value) {
                      gameId[i] = value!;
                    },
                    onChanged: (value) {
                      setState(() {
                        gameId[i] = value;
                      });
                    },
                    validator: (value) {
                      if (value != null) {
                        if (value.toString().trim().length <= 14 &&
                            value.toString().trim().length != 0) {
                          return null;
                        } else
                          return "enter valid ${widget.game} name";
                      }
                      // _showMessage("Enter valid Email or Username!");
                      return ("invalid");
                    },
                    style: TextStyle(
                        letterSpacing: 1,
                        wordSpacing: 3,
                        fontSize: 17,
                        fontWeight: FontWeight.w800),
                    autofocus: _focusBool[i],
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      helperText: widget.game + " unique name",
                      contentPadding: EdgeInsets.only(
                          left: 15, right: 10, top: 0, bottom: 0),
                      filled: true,
                      hoverColor: Colors.green,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 20),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "game id",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
          tileColor: Colors.white,
          minVerticalPadding: 30,
          leading: Icon(
            Icons.person,
            size: 40,
          ),
          title: Text(
            userName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      );
    }

    void _trySubmit() async {
      FocusScope.of(context).unfocus();
      bool isValid = _formKey.currentState!.validate();
      List k = List.generate(widget.teamSize, (i) => "Add Player ${(i + 1)}");
      bool isValidPlayer = true;
      if (widget.teamSize == 1) {
        if (userName[0] == "Add Player") {
          //  print(userName[i] + "   " + k[i]);
          isValidPlayer = false;
        }
      } else {
        for (int i = 0; i < widget.teamSize; i++) {
          if (userName[i] == k[i]) {
            print(userName[i] + "   " + k[i]);
            isValidPlayer = false;
            break;
          }
          int flag = 0;
          for (int j = i + 1; j < widget.teamSize; j++) {
            if (userName[i] == userName[j]) {
              //print(userName[i] + "   " + k[i]);
              isValid = false;
              flag = 1;
              break;
            }
          }
          if (flag == 1) {
            fToast.showToast(
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_off_outlined,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "Remove Dublicate Players ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              gravity: ToastGravity.BOTTOM,
              toastDuration: Duration(seconds: 2),
            );

            break;
          }
        }
      }
      if (isValid && isValidPlayer) {
        setState(() {
          this._formKey.currentState!.save();
          // _isLoading = true;
        });
        add();

        fToast.showToast(
          child: Container(
            height: 60,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.black,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_add_alt_outlined,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  "Succesful ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );
      }
      if (!isValidPlayer) {
        fToast.showToast(
          child: Container(
            height: 60,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.black,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_add_alt_outlined,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  "Add All Players ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );
      }
    }

    return Container(
        child: SingleChildScrollView(
            child: Form(
      key: _formKey,
      child: Column(
        children: [
          ...userName.map((e) {
            // setbuildvalue();
            playerIndex = playerIndex + 1;
            return playersWidget(e, playerIndex, widget.docs);
          }).toList(),
          Container(
            child: TextButton(
                onPressed: () {
                  //  FocusScope.of(context).unfocus();
                  _trySubmit();
                },
                child: Text("Finish")),
          )
        ],
      ),
    )));
  }
}

class UserSearch extends SearchDelegate<String> {
  Function updateList;
  List<QueryDocumentSnapshot<Object?>> docs;
  int index;
  String hostId;
  UserSearch(this.docs, this.index, this.updateList, this.hostId);

  List<String> l = ["sasikumar", "kiran", "gopi", "sasikiran"];
  int indexforDoc = 0;
  String temp = "";
  String user = "Hoster";
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear)),
    ]; // throw UnimplementedError();
  }

  //updateList(String uName, String dId, String pe, String em, int index)
  void addData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(temp)
        .get()
        .then((value) {
      updateList(value.get('userName'), temp, value.get('phone'),
          value.get('email'), index, value.get('profileUrl'));
    });
    // Navigator.of(context).pop();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    //throw UnimplementedError();
    if (temp != hostId) {
      addData();
      Navigator.of(context).pop();
    } else {
      query = "";
      return Column(
        children: [
          Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text(
                "You can not add $user. \n Because He/she is a Hoster of this Tournament",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              )),
          Icon(
            Icons.person_add_disabled_rounded,
            size: 40,
            color: Colors.green,
          )
        ],
      );
    }
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Text(
          "Added",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final list = query.isEmpty
        ? []
        : List.generate(docs.length, (index) {
            return [docs[index]['userName'], docs[index].id];
          }).where((user) => user[0].startsWith(query)).toList();
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              indexforDoc = index;
              temp = list[index][1];
              user = list[index][0];
              //addData();

              showResults(context);
            },
            //  selectedTileColor: Colors.grey,
            trailing: Icon(Icons.add),
            leading: Icon(Icons.person),
            title: RichText(
                text: TextSpan(
                    children: [
                  TextSpan(
                      text: list[index][0].substring(query.length),
                      style: TextStyle(color: Colors.grey, fontSize: 16))
                ],
                    text: list[index][0].substring(0, query.length),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17))),
          );
        });
    // TODO: implement buildSuggestions
    //throw UnimplementedError();
  }
}
