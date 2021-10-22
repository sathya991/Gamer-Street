import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/providers/google_signin_provider.dart';
import 'package:gamer_street/providers/tourney_provider.dart';
import 'package:gamer_street/providers/user_provider.dart';
import 'package:gamer_street/screens/Hosting.dart';
import 'package:gamer_street/screens/HostingGame.dart';
import 'package:gamer_street/screens/TabsScreenState.dart';
import 'package:gamer_street/screens/auth_screen.dart';
import 'package:gamer_street/screens/choose_screen.dart';
import 'package:gamer_street/screens/games_screen.dart';
import 'package:gamer_street/screens/email_verify_wait_screen.dart';
import 'package:gamer_street/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:gamer_street/screens/Gamestournamet.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => GoogleSigninProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => UserDataProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => TourneyProvider(),
              )
            ],
            child: MaterialApp(
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
                    User? _user = FirebaseAuth.instance.currentUser;
                    if (_user!.emailVerified) {
                      return TabsScreenState();
                    } else if (!_user.emailVerified) {
                      return EmailVerifyWaitScreen();
                    }
                  }
                  return ChooseScreen();
                },
              ),
              routes: {
                AuthScreen.authScreenRoute: (ctx) => AuthScreen(),
                EmailVerifyWaitScreen.otpScreenRoute: (ctx) =>
                    EmailVerifyWaitScreen(),
                TabsScreenState.tabsRouteName: (ctx) => TabsScreenState(),
                GamesTournament.gamesTournamentRoute: (ctx) =>
                    GamesTournament(),
                Hosting.HostingRoute: (ctx) => Hosting(),
                HostingGame.Hosting_Game: (ctx) => HostingGame(),
              },
            ),
          );
        }
        return SplashScreen();
      },
      future: Firebase.initializeApp(),
    );
  }
}
