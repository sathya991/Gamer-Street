import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamer_street/providers/google_signin_provider.dart';
import 'package:gamer_street/providers/user_provider.dart';
import 'package:gamer_street/screens/addDetailsGoogleScreen.dart';
import 'package:gamer_street/screens/email_verify_wait_screen.dart';
import 'package:gamer_street/services/storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignupWidget extends StatefulWidget {
  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final SecureStorage secureStorage = SecureStorage();
  bool _userNameChecking = false;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _email = "";
  String _password = "";
  String _userName = "";
  bool _passwordNotVisible = true;
  //function to check if the given number is a number or not.
  //Validating if given input is a number or an email
  String userData = "";
  _scaffoldMessenger(BuildContext context, String txt) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(txt),
      duration: Duration(seconds: 3),
    ));
  }

  loadingSet(bool val) {
    setState(() {
      _isLoading = val;
    });
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

  void register() async {
    if (userData == "Username already taken") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Use a different Username"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    if (_formKey.currentState!.validate()) {
      loadingSet(true);
      var curInstance = FirebaseAuth.instance;
      _formKey.currentState!.save();
      try {
        UserCredential userCredential = await curInstance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'userName': _userName,
          'email': _email,
          'gamesHosted': 0,
          'gamesPlayed': 0,
          'gamesWon': 0,
          'hostSuccess': 0,
          'phone': "",
          'hosterRank': 'noRank',
          'hosterTier': 'noTier',
          'hosterTierUrl': '',
          'hosterTierNo': 1,
          'playerRank': 'noRank',
          'playerTier': 'noTier',
          'playerTierNo': 1,
          'playerTierUrl': '',
          'profileUrl': '',
        }).then((_) async {
          secureStorage.writeSecureData('userName', _userName);
          User? curUser = FirebaseAuth.instance.currentUser;
          if (curUser != null && !curUser.emailVerified) {
            await curUser.sendEmailVerification();
          }
          Navigator.of(context).pushNamedAndRemoveUntil(
              EmailVerifyWaitScreen.otpScreenRoute, (route) => false,
              arguments: {'password': _password});
        });
      } on FirebaseAuthException catch (e) {
        loadingSet(false);
        if (e.code == 'weak-password') {
          _scaffoldMessenger(context, 'The password provided is too weak');
        } else if (e.code == 'email-already-in-use') {
          _scaffoldMessenger(
              context, 'The account already exists for that email');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
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
                    validator: (txt) => userProvider.userNameValidator(txt),
                    autocorrect: true,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      suffix: SizedBox(
                          height: 17,
                          width: 17,
                          child: _userNameChecking
                              ? CircularProgressIndicator()
                              : null),
                      labelText: "Username",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (tx) {
                      _userName = tx!;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: Text(
                      userData,
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    validator: (txt) => userProvider.emailValidator(txt),
                    autocorrect: true,
                    enableSuggestions: true,
                    onSaved: (tx) {
                      _email = tx!;
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    validator: (txt) => userProvider.passwordValidator(txt),
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _passwordNotVisible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _passwordNotVisible = !_passwordNotVisible;
                          });
                        },
                      ),
                      labelText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    obscureText: _passwordNotVisible,
                    onSaved: (tx) {
                      _password = tx!;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(onPressed: register, child: Text("Signup")),
                  SizedBox(
                    height: 10,
                  ),
                  Text("--or--"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.green,
                      ),
                      TextButton(
                        child: Text("Join with Google"),
                        onPressed: () {
                          final provider = Provider.of<GoogleSigninProvider>(
                              context,
                              listen: false);
                          provider.googleLogin(false).then((value) async {
                            final _curEmail =
                                FirebaseAuth.instance.currentUser!.email;
                            GoogleSignIn().disconnect();
                            FirebaseAuth.instance.currentUser!.delete();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                DetailGoogleScreen.googleDetailsScreen,
                                (route) => false,
                                arguments: _curEmail);
                          }).catchError((e) {
                            GoogleSignIn().disconnect();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ));
  }
}
