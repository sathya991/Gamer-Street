import 'package:cloud_firestore/cloud_firestore.dart';

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

  // Getting userdata from secure Storage which is already with us
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
    });
  }
}
// This class is need to be updated in future
// 1. writing should be enabled