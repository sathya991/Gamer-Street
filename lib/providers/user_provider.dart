import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/services/storage.dart';

class UserDataProvider extends ChangeNotifier {
  String userName = "";
  // Future getUsername(String userId) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .get()
  //       .then((value) async {
  //     userName = await value.get('userName');
  //   });
  //   return userName;
  // }

  final SecureStorage secureStorage = SecureStorage();
  String _password = "";
  String? passwordValidator(String? txt) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (txt!.isEmpty) {
      return "Please Enter a valid password";
    } else {
      if (txt.length < 8) {
        return 'Password must be atleast 8 characters';
      } else if (txt.length >= 8) {
        if (!regex.hasMatch(txt))
          return """Password should contain:\n
                * atleast one special character\n
                * atleast one uppercase character\n
                * atleast one number""";
      } else {
        return null;
      }
    }
    notifyListeners();
  }

  String? emailValidator(String? txt) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(txt!);
    if (!emailValid) {
      return "Enter a valid Email";
    }
    return null;
  }

  String? userNameValidator(String? txt) {
    String? returnStatement;
    if (txt!.length < 5) {
      returnStatement = "Username must be atleast 5 characters long.";
    }
    if (txt.length > 15) {
      returnStatement = "Username must be smaller than 16 characters long.";
    } else {
      returnStatement = null;
    }
    return returnStatement;
  }

  // Future addUserData() async {
  //   final User? _curUser = FirebaseAuth.instance.currentUser;
  //   if (_curUser != null) {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(_curUser.uid)
  //         .set({
  //       'userName': _curUser.displayName,
  //       'admin': false,
  //       'email': _curUser.email!,
  //       'gamesPlayed': 0,
  //       'gamesWon': 0,
  //       'phone': "",
  //       'rank': 'noRank',
  //     });
  //   }
  // }

  Future _deleteFromDb() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
  }

  Future deleteAccount() async {
    var _password = await secureStorage.readSecureData('password');
    final User? _curUser = FirebaseAuth.instance.currentUser;
    if (_curUser != null) {
      try {
        await _deleteFromDb();
        await _curUser.delete();
        await secureStorage.deleteSecureData('password');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          AuthCredential credential = EmailAuthProvider.credential(
              email: _curUser.email.toString(), password: _password);
          await FirebaseAuth.instance.currentUser!
              .reauthenticateWithCredential(credential);
          await _deleteFromDb();
          await FirebaseAuth.instance.currentUser!.delete();
          await secureStorage.deleteSecureData('password');
        }
      }
    }
  }
}
