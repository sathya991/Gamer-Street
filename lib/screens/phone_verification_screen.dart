import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/screens/TabsScreenState.dart';

class PhoneVerificationScreen extends StatefulWidget {
  static final String phoneVerificationScreen = '/phone-verification-screen';
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  validatePhoneNumber(String txt) {
    if (txt.isEmpty) {
      return "Enter a Proper Mobile Number";
    } else if (txt.length != 10) {
      return "Please check your mobile number";
    }
    return null;
  }

  String phoneNumber = "";
  addPhoneNumber() async {
    _formKey.currentState!.save();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'phone': phoneNumber});
    Navigator.of(context).popAndPushNamed(TabsScreenState.tabsRouteName);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (txt) => validatePhoneNumber(txt!),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(hintText: "Mobile Number"),
                      onSaved: (txt) {
                        phoneNumber = txt!;
                      },
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    addPhoneNumber();
                  },
                  child: Text("Add")),
              SizedBox(
                height: 10,
              ),
              Text("We Promise to send you only the important stuff.")
            ],
          ),
        ),
      ),
    );
  }
}
