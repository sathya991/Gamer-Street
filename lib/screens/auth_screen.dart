import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/Widgets/LoginWidget.dart';

class AuthScreen extends StatefulWidget {
  static const String authScreenRoute = "/auth-screen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    var loginCheck =
        ModalRoute.of(context)!.settings.arguments as Map<String, bool>;
    bool check = loginCheck['val'] as bool;
    return Scaffold(
      appBar: AppBar(
        title: Text("GamerStreet"),
      ),
      body: Center(
        child: check ? Login() : Text("SignUp"),
      ),
    );
  }
}
