import 'package:flutter/material.dart';
import 'package:gamer_street/screens/auth_screen.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _chooseAuth(bool loginCheck) {
      Navigator.pushNamed(context, AuthScreen.authScreenRoute,
          arguments: {"val": loginCheck});
    }

    Size _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("New Gamer?", style: TextStyle(fontSize: 30)),
              ElevatedButton(
                  onPressed: () => _chooseAuth(false), child: Text("SignUp")),
              SizedBox(
                height: (_deviceSize.height) * 3 / 100,
              ),
              Text("Already a Pro?", style: TextStyle(fontSize: 30)),
              ElevatedButton(
                  onPressed: () => _chooseAuth(true), child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
