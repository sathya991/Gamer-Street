import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/providers/chat_provider.dart';
import 'package:gamer_street/providers/google_signin_provider.dart';
import 'package:gamer_street/providers/theme_provider.dart';
import 'package:gamer_street/providers/tourney_provider.dart';
import 'package:gamer_street/providers/user_provider.dart';
import 'package:gamer_street/screens/Hosting.dart';
import 'package:gamer_street/screens/HostingGame.dart';
import 'package:gamer_street/screens/TabsScreenState.dart';
import 'package:gamer_street/screens/addDetailsGoogleScreen.dart';
import 'package:gamer_street/screens/auth_screen.dart';
import 'package:gamer_street/screens/choose_screen.dart';
import 'package:gamer_street/screens/email_verify_wait_screen.dart';
import 'package:gamer_street/screens/know_more_screen.dart';
import 'package:gamer_street/screens/phone_verification_screen.dart';
import 'package:gamer_street/screens/profile.dart';
import 'package:gamer_street/screens/settingsScreen.dart';
import 'package:gamer_street/screens/splash_screen.dart';
import 'package:gamer_street/screens/themesScreen.dart';
import 'package:gamer_street/screens/tournamentDetailScreen.dart';
import 'package:gamer_street/services/storage.dart';
import 'package:provider/provider.dart';
import 'package:gamer_street/screens/Gamestournament.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static const String appName = "GamerSteet";

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SecureStorage secureStorage = SecureStorage();

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
                ),
                ChangeNotifierProvider(
                  create: (context) => ThemeProvider(),
                ),
                ChangeNotifierProvider(create: (context) => ChatProvider()),
              ],
              child: Consumer<ThemeProvider>(builder: (_, theme, __) {
                return MaterialApp(
                  title: 'GamerStreet',
                  theme: theme.themeData,
                  home: StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
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
                    DetailGoogleScreen.googleDetailsScreen: (ctx) =>
                        DetailGoogleScreen(),
                    SettingsScreen.settingScreenRoute: (ctx) =>
                        SettingsScreen(),
                    ThemeScreen.themeScreenRoute: (ctx) => ThemeScreen(),
                    KnowMoreScreen.knowMoreScreenRoute: (ctx) =>
                        KnowMoreScreen(),
                    // Profile.profile: (ctx) => Profile(),
                  },
                  onGenerateRoute: (data) {
                    if (data.name == Profile.profile) {
                      final String profileUrl = data.arguments as String;
                      return MaterialPageRoute(
                          builder: (_) => Profile(
                                profileUrl: profileUrl,
                              ));
                    }
                    if (data.name ==
                        TournamentDetailScreen.tournamentDetailScreenRoute) {
                      final curData = data.arguments as Map;
                      return MaterialPageRoute(
                          builder: (_) => TournamentDetailScreen(
                              curData['tId'], curData['game']));
                    }
                    return null;
                  },
                );
              }));
        }
        return SplashScreen();
      },
      future: Firebase.initializeApp(),
    );
  }
}
