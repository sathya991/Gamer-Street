import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/appDrawer.dart';
import 'package:gamer_street/screens/RegistrationsScreen.dart';
import 'package:gamer_street/screens/games_screen.dart';

class TabsScreenState extends StatefulWidget {
  static const tabsRouteName = '/tabs-screen';
  const TabsScreenState({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<TabsScreenState> with TickerProviderStateMixin {
  List<Widget> _widgets = [];
  late TabController _tabController;
  int index = 0;
  List<String> appBarNames = ["Games", "Registrations"];
  String appBarName = "Games";
  void _handleSelected() {
    setState(() {
      appBarName = appBarNames[_tabController.index];
    });
  }

  @override
  void initState() {
    super.initState();
    _widgets = [GamesScreen(isHosting: false), RegistrationsScreen()];
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(_handleSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarName),
        bottom: new TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.games),
              text: appBarNames[0],
            ),
            Tab(
              icon: Icon(Icons.app_registration),
              text: appBarNames[1],
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
      body: TabBarView(controller: _tabController, children: _widgets),
    );
  }
}
