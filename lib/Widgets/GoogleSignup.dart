import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/providers/user_provider.dart';
import 'package:gamer_street/screens/email_verify_wait_screen.dart';
import 'package:provider/provider.dart';

class GoogleSignup extends StatefulWidget {
  final String email;
  GoogleSignup(this.email);

  @override
  _GoogleSignupState createState() => _GoogleSignupState();
}

class _GoogleSignupState extends State<GoogleSignup> {
  String userData = "";
  bool _userNameChecking = false;
  bool _isPasswordNotVisible = true;
  String _userName = "";
  String _passWord = "";
  String _curEmail = "";
  @override
  void initState() {
    super.initState();
    _curEmail = widget.email;
  }

  void _registerUser() async {
    if (userData == "Username already taken") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Use a different Username"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _curEmail, password: _passWord);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'userName': _userName,
          'admin': false,
          'email': _curEmail,
          'gamesPlayed': 0,
          'gamesWon': 0,
          'phone': "",
          'rank': 'noRank',
        }).then((_) async {
          User? curUser = FirebaseAuth.instance.currentUser;
          if (curUser != null && !curUser.emailVerified) {
            await curUser.sendEmailVerification();
          }
          Navigator.of(context).pushNamedAndRemoveUntil(
              EmailVerifyWaitScreen.otpScreenRoute, (route) => false);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _scaffoldMessenger(context, 'The password provided is too weak');
        } else if (e.code == 'email-already-in-use') {
          _scaffoldMessenger(
              context, 'The account already exists for that email');
        }
      }
    }
  }

  _scaffoldMessenger(BuildContext context, String txt) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(txt),
      duration: Duration(seconds: 3),
    ));
  }

  Future<bool> usernameCheck(String username) async {
    setState(() {
      _userNameChecking = true;
    });
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('userName', isEqualTo: username)
        .get();
    return result.docs.isEmpty;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text("Update your Information to proceed"),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              decoration: InputDecoration(
                suffix: SizedBox(
                    height: 17,
                    width: 17,
                    child:
                        _userNameChecking ? CircularProgressIndicator() : null),
                label: Text("Username"),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onChanged: (_curUserName) async {
                final valid = await usernameCheck(_curUserName);
                if (!valid) {
                  setState(() {
                    userData = "Username already taken";
                    _userNameChecking = false;
                  });
                } else {
                  setState(() {
                    userData = "";
                    _userNameChecking = false;
                  });
                }
              },
              validator: (txt) => provider.userNameValidator(txt),
              onSaved: (tx) {
                _userName = tx!;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: _isPasswordNotVisible,
              decoration: InputDecoration(
                label: Text("Password"),
                suffixIcon: IconButton(
                  icon: _isPasswordNotVisible
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    _isPasswordNotVisible = !_isPasswordNotVisible;
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (txt) => provider.passwordValidator(txt),
              onSaved: (tx) {
                _passWord = tx!;
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: _registerUser, child: Text("Signup")),
          ],
        ),
      ),
    );
  }
}
