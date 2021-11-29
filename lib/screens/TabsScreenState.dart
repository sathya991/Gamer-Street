import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:gamer_street/screens/Gamestournament.dart';
import 'package:gamer_street/screens/Hosting.dart';
import 'package:gamer_street/screens/RegistrationsScreen.dart';
import 'package:gamer_street/screens/games_screen.dart';
import 'package:gamer_street/screens/know_more_screen.dart';
import 'package:gamer_street/screens/profile.dart';
import 'package:gamer_street/screens/seasonScreen.dart';
import 'package:gamer_street/screens/settingsScreen.dart';

class TabsScreenState extends StatefulWidget {
  static const tabsRouteName = '/tabs-screen';
  const TabsScreenState({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<TabsScreenState> with TickerProviderStateMixin {
  int index = 0;
  String gameName = "all";
  func(value, gameNameBack) {
    setState(() {
      index = value;
      gameName = "all";
    });
  }

  void _handleSelected(int ind) {
    setState(() {
      index = ind;
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Settings':
        Navigator.of(context).pushNamed(SettingsScreen.settingScreenRoute);
        break;
      case 'Know more':
        Navigator.of(context).pushNamed(KnowMoreScreen.knowMoreScreenRoute);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [
      GamesScreen(
        isHosting: false,
        func: func,
      ),
      GamesTournament(gameName),
      SeasonScreen(),
      Profile(profileUrl: FirebaseAuth.instance.currentUser!.uid)
    ];
    return Scaffold(
      appBar: index != 3
          ? AppBar(
              title: Row(
                children: [
                  Text(
                    "Gamer",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                  Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        'Street',
                        style: TextStyle(
                          fontSize: 23,
                          fontStyle: FontStyle.italic,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3.5
                            ..color = Colors.black,
                        ),
                      ),
                      // Solid text as fill.
                      Text(
                        'Street',
                        style: TextStyle(
                          fontSize: 23,
                          fontStyle: FontStyle.italic,
                          color: Colors.redAccent.shade700,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Settings', 'Know more'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            )
          : null,
      body: Center(
        child: _widgets.elementAt(index),
      ),
      floatingActionButton: index == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(Hosting.HostingRoute, arguments: true);
              },
              child: FaIcon(FontAwesomeIcons.plus),
              backgroundColor: Colors.red,
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.gamepad),
            label: 'Tournaments',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.trophy),
            label: 'Season',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
        currentIndex: index,
        selectedItemColor: Colors.amber[800],
        onTap: _handleSelected,
      ),
    );
  }
}
