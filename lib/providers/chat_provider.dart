import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  Future sendMessage(String tourneyId, String message, String userId,
      String userName, DateTime sentTime) async {
    await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(tourneyId)
        .collection('chat')
        .doc()
        .set({
      'content': message,
      'userId': userId,
      'userName': userName,
      'sentTime': sentTime,
    });
  }
}
