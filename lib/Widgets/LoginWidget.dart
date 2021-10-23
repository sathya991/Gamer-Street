import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:gamer_street/screens/TabsScreenState.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
//Forgot password flag
  bool forgotpassword = false;

//Navigation to Gamer Street
  bool logged = false;
  void navigation() {
    if (logged == false) {
      _showMessage("Succesfully you are logging in...");
      logged = true;
      Navigator.pushNamedAndRemoveUntil(
          context, TabsScreenState.tabsRouteName, (route) => false);
    }
  }

//Cheking userid in Database
  static var _usernameEmail = '';
  var _usernameEmailFlag = false;
  Future<bool> getuserid(String username) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("users").get();
    bool flag = false;
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      if (a['userName'] == username) {
        flag = true;
        _usernameEmailFlag = true;
        _usernameEmail = a['email'];
        break;
      }
    }

    return (flag);
  }

//validator for for resend Forgot password
  var _email;
  void _repassword() async {
    final isValid = _formKeyResetpassword.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        this._formKeyResetpassword.currentState!.save();
        _isLoading = true;
      });
      try {
        print(_userEmail);
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        setState(() {
          _isLoading = false;
          forgotpassword = false;
          _showMessage("Check your Mail");
        });
      } on FirebaseAuthException catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
        });
        _showMessage("No user found. Try again!");
      }
    }
  }

//Snakbar to show user error activity messages
  void _showMessage(String str) {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text(str),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    });
  }

  //formfieldtext data
  final _formKey = GlobalKey<FormState>();
  final _formKeyResetpassword = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';
  bool _isLoading = false;
  User? user;

  //Google sign-in if user is found
  void signin() async {
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();
    if (account != null) {
      final auth = await account.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: auth.idToken, accessToken: auth.accessToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser ||
          userCredential.additionalUserInfo == null) {
        _showMessage("No User found!");
        await userCredential.user!.delete();
        await GoogleSignIn().disconnect();
        await GoogleSignIn().signOut();
        await FirebaseAuth.instance.signOut();
      } else {
        _showMessage("Succesfully Logged in");
        navigation();
      }
    } else {
      _showMessage("You didn't Choose a Google account");
    }
  }

//Form Submitting and validating
  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      setState(() {
        this._formKey.currentState!.save();
        _isLoading = true;
      });
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _userEmail,
          password: _userPassword,
        );
        user = userCredential.user;
        setState(() {
          _showMessage("Succesfully you are logging in...");
          _isLoading = false;
          navigation();
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (e.code == 'user-not-found') {
          _showMessage(
              "No User found! try again or create GamerStreet Account  ");
        } else if (e.code == 'wrong-password') {
          _showMessage("Email or Passworrd in-correct!");
        }
      }
    }
  }

//Validating Email
  String _checkValid(String value) {
    if (value.isEmpty) {
      _showMessage("Enter valid Email or Username!");
      return "invalid";
    } else {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return ("valid");
      }

      return ("invalid");
    }
  }

  var valid;
//Build Method
  @override
  Widget build(BuildContext context) {
    return forgotpassword == false
        ? Card(
            elevation: 10,
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value != null) {
                                if (_checkValid(value.toString().trim()) ==
                                    'valid') {
                                  return null;
                                }
                                if (valid == true) return (null);

                                return ("invalid");
                              }
                              _showMessage("Enter valid Email or Username!");
                              return ("invalid");
                            },
                            onChanged: (value) async {
                              valid = await getuserid(value.toString().trim());
                            },
                            onSaved: (value) {
                              if (_usernameEmailFlag == true) {
                                _userEmail = _usernameEmail;
                              } else {
                                _userEmail = value!;
                                print(_userEmail);
                              }
                              _usernameEmailFlag = false;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email/Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(width: 5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (value) {
                              value = value.toString();
                              getuserid(value);
                              return (value.isEmpty || value.length < 8)
                                  ? "password must be minimum of 8 characters!"
                                  : null;
                            },
                            onSaved: (value) {
                              _userPassword = value!;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(width: 5),
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  forgotpassword = true;
                                });
                              },
                              child: Text(
                                "Forget Password",
                                style: TextStyle(color: Colors.blue),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 30,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: _isLoading
                                ? SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: Colors.green,
                                      strokeWidth: 4,
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    onPressed: _trySubmit,
                                    child: Text("Login"),
                                  ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                "--Or--",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              signin();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(" Sign-in with Google "),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    height: 25,
                                    width: 25,
                                    child: FaIcon(
                                      FontAwesomeIcons.google,
                                      color: Colors.green,
                                    ),
                                    //  Image.asset("assets/images/google.png"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child:
                      OutlinedButton(onPressed: () {}, child: Text("Sign-up")),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        : Card(
            elevation: 10,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                  key: _formKeyResetpassword,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return _checkValid(value.toString().trim()) == "valid"
                              ? null
                              : "invalid email";
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(width: 5),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 30,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: _isLoading
                            ? SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                  strokeWidth: 4,
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {
                                  _repassword();
                                },
                                child: Text("Reset password"),
                              ),
                      ),
                    ],
                  )),
            ),
          );
  }
}
