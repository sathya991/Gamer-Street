import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_easyloading/flutter_easyloading.dart';

class MessageView extends StatefulWidget {
  final message;
  final isMe;
  final userName;
  final hostId;
  final messageId;
  const MessageView(
      this.message, this.isMe, this.hostId, this.messageId, this.userName,
      {Key? key})
      : super(key: key);

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: widget.isMe ? Colors.red : Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: visibleText(widget.hostId, widget.messageId,
                      widget.isMe, widget.userName)),
              Divider(
                height: 2,
                color: Colors.black,
                thickness: 100,
              ),
              Container(
                child: Text(widget.message),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget visibleText(
      String hostId, String messageId, bool isMe, String userNameNow) {
    if (hostId == "") {
      return Text("Loading...");
    }
    bool isSame = hostId == messageId;
    if (isSame) {
      if (isMe) {
        return Text("You");
      }
      return Text("Host");
    } else {
      return Text(userNameNow);
    }
  }
}
