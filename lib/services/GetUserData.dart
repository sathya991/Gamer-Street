import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamer_street/services/Self.dart';
import 'package:gamer_street/services/UserData.dart';

class GetUserData extends UserData {
  static Future<Self> self() async {
    Self m = new Self();
    return await m.userData().then((value) {
      return value;
    });
  }

  static Future<UserData> usersData(String profilrUrl) async {
    UserData j = new UserData();
    return await j.userData(profilrUrl);
  }
}
