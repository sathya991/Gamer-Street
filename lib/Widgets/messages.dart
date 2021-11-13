import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/messageView.dart';
import 'package:gamer_street/services/storage.dart';

class Messages extends StatefulWidget {
  final tourneyId;
  const Messages(this.tourneyId, {Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  SecureStorage secureStorage = SecureStorage();
  String userName = "";
  getUserName() async {
    userName = await secureStorage.readSecureData('userName');
  }

  getMessages() {
    getUserName();
    return FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyId)
        .collection('chat')
        .orderBy('sentTime', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getMessages(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 200,
            );
          } else if (snapshot.hasData) {
            final messages = snapshot.data!;
            return messages.docs.isEmpty
                ? buildText("Say hi")
                : Flexible(
                    child: ListView.builder(
                        itemCount: messages.docs.length,
                        reverse: true,
                        itemBuilder: (ctx, index) {
                          final curMessage = messages.docs[index];
                          final isMe = curMessage.get('userName') == userName;
                          return MessageView(curMessage.get('content'), isMe,
                              curMessage.get('userName'));
                        }),
                  );
          } else {
            return Text('data');
          }
        });
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
