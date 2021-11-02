import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TourneyProvider extends ChangeNotifier {
  Future getTourneyData(String id) async {
    return await FirebaseFirestore.instance
        .collection('tournaments')
        .doc(id)
        .collection('basicInfo')
        .get();
  }
}
