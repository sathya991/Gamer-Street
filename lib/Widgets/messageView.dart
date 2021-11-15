import 'package:flutter/material.dart';

class MessageView extends StatefulWidget {
  final message;
  final isMe;
  final userName;
  final isHost;
  const MessageView(this.message, this.isMe, this.isHost, this.userName,
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
                  child:
                      visibleText(widget.isHost, widget.isMe, widget.userName)),
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

  Widget visibleText(bool isHost, bool isMe, String userNameNow) {
    if (isHost && isMe) {
      return Text("You");
    }
    if (isHost) {
      return Text("Host");
    } else if (isMe) {
      return Text("You");
    } else {
      return Text(userNameNow);
    }
  }
}
