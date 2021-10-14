import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/screens/TabsScreenState.dart';

class EmailVerifyWaitScreen extends StatefulWidget {
  static const String otpScreenRoute = "/otp-screen";
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<EmailVerifyWaitScreen> {
  bool _isUserEmailVerified = false;
  dynamic _timer;

  @override
  void initState() {
    super.initState();
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
        FirebaseAuth.instance.currentUser!..reload();
        var user = FirebaseAuth.instance.currentUser;
        if (user!.emailVerified) {
          setState(() {
            _isUserEmailVerified = user.emailVerified;
            Navigator.pushNamedAndRemoveUntil(
                context, TabsScreenState.tabsRouteName, (route) => false);
          });
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  int _resendCount = 0;
  @override
  Widget build(BuildContext context) {
    Future<void> _resendEmail() async {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Verification Mail has been sent again"),
        duration: Duration(seconds: 2),
      ));
    }

    Widget _emailVerification = Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please Verify your Email to Proceed"),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: _resendCount <= 3 ? _resendEmail : null,
            child: Text("Resend"),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
    return Scaffold(
      body: _emailVerification,
    );
  }
}
