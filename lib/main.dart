import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/screens/auth_screen.dart';
import 'package:gamer_street/screens/choose_screen.dart';
import 'package:gamer_street/screens/games_screen.dart';
import 'package:gamer_street/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String appName = "GamerSteet";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                }
                if (userSnapshot.hasData) {
                  return GamesScreen();
                }
                return ChooseScreen();
              },
            ),
            routes: {
              AuthScreen.authScreenRoute: (ctx) => AuthScreen(),
            },
          );
        }
        return SplashScreen();
      },
      future: Firebase.initializeApp(),
    );
  }
}
