import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/providers/chat_provider.dart';
import 'package:gamer_street/services/storage.dart';
import 'package:provider/provider.dart';

class MessageType extends StatefulWidget {
  final tourneyId;
  const MessageType(this.tourneyId, {Key? key}) : super(key: key);

  @override
  _MessageTypeState createState() => _MessageTypeState();
}

class _MessageTypeState extends State<MessageType> {
  late final chatProvider;
  SecureStorage secureStorage = SecureStorage();
  final _controller = TextEditingController();
  String message = "";
  final userId = FirebaseAuth.instance.currentUser!.uid;

  void sendMessage() async {
    final userName = await secureStorage.readSecureData('userName');
    FocusScope.of(context).unfocus();
    final sentTime = DateTime.now();
    chatProvider.sendMessage(
        widget.tourneyId, message, userId, userName, sentTime);
    _controller.clear();
  }

  @override
  void initState() {
    super.initState();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                labelText: 'Message',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) => setState(() {
                message = value;
              }),
            ),
          ),
          SizedBox(width: 20),
          GestureDetector(
            onTap: message.trim().isEmpty ? null : sendMessage,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
