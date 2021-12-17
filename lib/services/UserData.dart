import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamer_street/services/Self.dart';
import 'package:gamer_street/services/UserData.dart';

class UserData {
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
  Future<UserData> userData(String profilrUrl) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(profilrUrl)
        .get()
        .then((value) async {
      this.email = value.get("email");
      this.userName = value.get("userName");
      this.phone = value["phone"].toString();
      this.gamesHosted = value.get("gamesHosted");
      this.gamesPlayed = value.get("gamesPlayed");
      this.gamesWon = value.get("gamesWon");
      this.hostSuccess = value.get("hostSuccess");
      this.hosterRank = value.get("hosterRank");
      this.hosterTier = value.get("hosterTier");
      this.hosterTierUrl = value.get("hosterTierUrl");
      this.playerRank = value.get("playerRank");
      this.playerTier = value.get("playerTier");
      this.playerTierNo = value.get("playerTierNo");
      this.playerTierUrl = value.get("playerTierUrl");
      this.profileUrl = value.get("profileUrl");
      return this;

      // await Self.write("gamesHosted", value.get("gamesHosted"));

      // await Self.write("gamesPlayed", value.get("gamesPlayed"));

      // await Self.write("gamesWon", value.get("gamesWon"));

      // await Self.write("hostSuccess", value.get("hostSuccess"));

      // await Self.write("hosterRank", value.get("hosterRank"));

      // await Self.write("hosterTier", value.get("hosterTier"));

      // await Self.write("hosterTierNo", value.get("hosterTierNo"));

      // await Self.write("hosterTierUrl", value.get("hosterTierUrl"));

      // await Self.write("playerRank", value.get("playerRank"));

      // await Self.write("playerTier", value.get("playerTier"));

      // await Self.write("playerTierNo", value.get("playerTierNo"));

      // await Self.write("playerTierUrl", value.get("playerTierUrl"));

      // await Self.write("profileUrl", value.get("profileUrl"));
    });
  }
}
