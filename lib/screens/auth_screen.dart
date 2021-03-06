import 'package:flutter/material.dart';

import 'package:gamer_street/Widgets/Signup.dart';

import '/Widgets/LoginWidget.dart';

class AuthScreen extends StatefulWidget {
  static const String authScreenRoute = "/auth-screen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    var loginCheck =
        ModalRoute.of(context)!.settings.arguments as Map<String, bool>;
    bool check = loginCheck['val'] as bool;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Center(
              child: check ? Login() : SignupWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
