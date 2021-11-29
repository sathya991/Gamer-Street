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
  List<Widget> _widgets = [
    GamesTournament("all"),
    SeasonScreen(),
    Profile(profileUrl: FirebaseAuth.instance.currentUser!.uid)
  ];
  int index = 0;
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
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Center(
        child: _widgets.elementAt(index),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(Hosting.HostingRoute, arguments: true);
        },
        child: FaIcon(FontAwesomeIcons.plus),
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
