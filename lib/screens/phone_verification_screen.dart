import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/screens/TabsScreenState.dart';

class PhoneVerificationScreen extends StatefulWidget {
  static const phoneVerificationRoute = '/phone-verification-route';
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  int count = 60;
  late Timer _timer;
  bool resendOpen = false;
  Future addNumber() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'phone': phoneNumber});
    Navigator.of(context).popAndPushNamed(TabsScreenState.tabsRouteName);
  }

  String phoneNumber = "";
  String otp = "";
  verifyPhoneNumber() {
    _formKey.currentState!.save();
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {
          addNumber();
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Wrong otp/Mobile Number")));
        },
        codeSent: (String verificationId, int? resendToken) {
          timeShow();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            count = 60;
            resendOpen = false;
          });
        });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: "Mobile Number"),
                        onSaved: (txt) {
                          phoneNumber = txt!;
                        },
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "OTP"),
                      onSaved: (txt) {
                        otp = txt!;
                      },
                    )
                  ],
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Verify")),
              resendOpen
                  ? TextButton(onPressed: () {}, child: Text("Resend OTP"))
                  : Text('$count')
            ],
          ),
        ),
      ),
    );
  }

  void timeShow() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (count == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            count--;
          });
        }
      },
    );
  }
}
