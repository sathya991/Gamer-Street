import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/games_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';
  bool _isLoading = false;
  User? user;

  Future<User?> signin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      googleSignIn.signIn();
    } catch (e) {
      print(e);
    }

    return user;
  }

  List<String> message = [
    "Enter valid Email or PhoneNumber!",
    "No user found!",
    "Email or Passworrd in correct!"
        "succsess"
  ];
  void _showMessage(int i) {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message[i]),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    });
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      setState(() {
        this._formKey.currentState!.save();
        _isLoading = true;
        print(_userEmail + "   " + _userPassword);
      });
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _userEmail,
          password: _userPassword,
        );
        user = userCredential.user;
        setState(() {
          // _showMessage(3);
          _isLoading = false;
          /* Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => GamesScreen()));*/
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => GamesScreen(),
            ),
            (route) => false,
          );
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (e.code == 'user-not-found') {
          _showMessage(1);
        } else if (e.code == 'wrong-password') {
          _showMessage(2);
        }
      }
    }
  }

  String _checkValid(String value) {
    if (value.isEmpty) {
      _showMessage(0);
      return "invalid";
    } else {
      if (int.tryParse(value) == null) {
        if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return ("valid");
        }
        _showMessage(0);
        return "invalid";
      } else if (value.length != 10) {
        return "invalid";
      } else
        return "valid";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        return _checkValid(value.toString()) == "valid"
                            ? null
                            : "invalid";
                      },
                      onSaved: (value) {
                        _userEmail = value!;
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
                        onPressed: null,
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
                                  borderRadius: new BorderRadius.circular(20.0),
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
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                              child:
                                  Image.asset("assets/images/googlelogo.jpeg"),
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
            child: OutlinedButton(onPressed: () {}, child: Text("Sign-up")),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
