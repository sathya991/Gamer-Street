import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/providers/google_signin_provider.dart';
import 'package:gamer_street/providers/user_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const settingScreenRoute = '/setting-screen';
  @override
  Widget build(BuildContext context) {
    Future<void> _deleteDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Are you sure you want to delete your account?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Provider.of<UserDataProvider>(context, listen: false)
                      .deleteAccount();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: () {}, child: Text("Themes")),
            TextButton(onPressed: () {}, child: Text("Notifications")),
            TextButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSigninProvider>(context, listen: false);
                  if (provider.isGoogleSignin) {
                    GoogleSignIn().disconnect();
                    provider.googleLogout();
                  } else {
                    FirebaseAuth.instance.signOut();
                  }
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                child: Text("Logout")),
            ElevatedButton(
              onPressed: () => _deleteDialog(),
              child: Text("Delete Account"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ],
        ),
      )),
    );
  }
}
