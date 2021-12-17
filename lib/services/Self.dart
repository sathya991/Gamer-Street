import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Self {
  String userName = "";
  String email = "";
  String phone = "";
  String gamesHosted = "";
  String gamesPlayed = "";
  String gamesWon = "";
  String hostSuccess = "";
  String hosterRank = "";
  String hosterTier = "";
  String hosterTierNo = "";
  String hosterTierUrl = "";
  String playerRank = "";
  String playerTier = "";
  String playerTierNo = "";
  String playerTierUrl = "";
  String profileUrl = "";
  static final _storage = FlutterSecureStorage();

  static Future write(String key, String value) async {
    return await _storage.write(key: key, value: value);
  }

  Future<Map<String, String>> read() async {
    return await _storage.readAll();
  }

  Future<Self> userData() async {
    return await read().then((value) {
      this.email = value["email"].toString();
      this.userName = value["userName"].toString();
      this.phone = value["phone"].toString();
      this.gamesHosted = value["gamesHosted"].toString();
      this.gamesPlayed = value["gamesPlayed"].toString();
      this.gamesWon = value["gamesWon"].toString();
      this.hostSuccess = value["hostSuccess"].toString();
      this.hosterRank = value["hosterRanthis"].toString();
      this.hosterTier = value["hosterTier"].toString();
      this.hosterTierUrl = value["hosterTierUrl"].toString();
      this.playerRank = value["playerRank"].toString();
      this.playerTier = value["playerTier"].toString();
      this.playerTierNo = value["playerTierNo"].toString();
      this.playerTierUrl = value["playerTierUrl"].toString();
      this.profileUrl = value["profileUrl"].toString();
      return this;
    });
  }

  static Future<dynamic> self() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      await Self.write("userName", value.get("userName"));

      await Self.write("email", value.get("email"));

      await Self.write("phone", value.get("phone"));

      await Self.write("gamesHosted", value.get("gamesHosted"));

      await Self.write("gamesPlayed", value.get("gamesPlayed"));

      await Self.write("gamesWon", value.get("gamesWon"));

      await Self.write("hostSuccess", value.get("hostSuccess"));

      await Self.write("hosterRank", value.get("hosterRank"));

      await Self.write("hosterTier", value.get("hosterTier"));

      await Self.write("hosterTierNo", value.get("hosterTierNo"));

      await Self.write("hosterTierUrl", value.get("hosterTierUrl"));

      await Self.write("playerRank", value.get("playerRank"));

      await Self.write("playerTier", value.get("playerTier"));

      await Self.write("playerTierNo", value.get("playerTierNo"));

      await Self.write("playerTierUrl", value.get("playerTierUrl"));

      await Self.write("profileUrl", value.get("profileUrl"));
    });
  }
}
