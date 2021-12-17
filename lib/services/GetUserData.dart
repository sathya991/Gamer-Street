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
