import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/GoogleSignup.dart';

class DetailGoogleScreen extends StatefulWidget {
  const DetailGoogleScreen({Key? key}) : super(key: key);
  static const googleDetailsScreen = '/google-detail-screen';
  @override
  _DetailGoogleScreenState createState() => _DetailGoogleScreenState();
}

class _DetailGoogleScreenState extends State<DetailGoogleScreen> {
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: GoogleSignup(email),
            )),
          ),
        ),
      ),
    );
  }
}
