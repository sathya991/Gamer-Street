import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/messageView.dart';
import 'package:gamer_street/services/storage.dart';

class Messages extends StatefulWidget {
  final tourneyId;
  final hostId;
  const Messages(this.tourneyId, this.hostId, {Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  SecureStorage secureStorage = SecureStorage();
  String userName = "";
  getUserName() async {
    userName = await secureStorage.readSecureData('userName');
  }

  var messageStream;

  getMessages() {
    getUserName();
    messageStream = FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.tourneyId)
        .collection('chat')
        .orderBy('sentTime', descending: true)
        .snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messageStream,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
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
                        return MessageView(
                            curMessage.get('content'),
                            isMe,
                            widget.hostId,
                            curMessage.get('userId'),
                            curMessage.get('userName'));
                      }),
                );
        });
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
      );
}
