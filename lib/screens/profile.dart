import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:gamer_street/Widgets/PlayedList.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamer_street/screens/EditProfile.dart';
import 'package:gamer_street/Widgets/CustomPageRoute.dart';

import 'package:gamer_street/providers/theme_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static const profile = '/profile-widget';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int change = 1;
  bool flag = true;
  Future<int> buildPotrait() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return 1;
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  Widget build(BuildContext context) {
    bool theme = Provider.of<ThemeProvider>(context).getThemeForProfile();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: theme ? Colors.black : Colors.white,
        backgroundColor: theme ? Colors.white : Colors.black,
        title: Text('sasi_bhumaraju'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(SlideRightRoute(page: EditProfile()));
                // Navigator.pushNamed(context, CustomPageRoute(child: EditProfile.Editprofile));
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: FutureBuilder(
          future: Future.wait([
            buildPotrait(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if ((snapshot.hasData)) {
              return Profilerender();
            } else {
              return Text('No data');
            }
          }),
    );
  }
}

class Profilerender extends StatefulWidget {
  const Profilerender({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilerenderState createState() => _ProfilerenderState();
}

class _ProfilerenderState extends State<Profilerender> {
  bool _isDragging = false;
  late Offset _offset;
  int bIndex = 0;
  double offsetSlide = 1;

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }

  void gets() {
    SharedPreferences.getInstance().then((value) {
      double dx = value.getDouble('Dx') ?? 10;
      double dy = value.getDouble('Dy') ?? 300;
      setState(() {
        _offset = Offset(dx, dy);
      });
    });
  }

  void initState() {
    gets();
    super.initState();
    _offset = Offset(10, 300);
  }

  bool flag = true;
  String phone = '76';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool theme = Provider.of<ThemeProvider>(context).getThemeForProfile();
    Widget a = Container(
      key: Key('1'),
      width: width * 0.458,
      child: Column(
        key: ValueKey(0),
        children: [
          Row(
            children: [
              Container(
                  width: width * 0.331,
                  height: width * 0.076388903,
                  child: Shimmer.fromColors(
                      period: Duration(milliseconds: 6000),
                      child: Text(
                        "9",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.0712963095),
                      ),
                      baseColor: Colors.green.shade900,
                      highlightColor: Colors.green.shade400)),
              SizedBox(
                width: width * 0.0101851871,
              ),
              Container(
                child: Text(
                  'Rank',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: width * 0.033101858),
                ),
              )
            ],
          ),
          Divider(
            thickness: 4,
          ),
          Row(
            children: [
              Container(
                width: width * 0.331,
                height: width * 0.076388903,
                child: Text(
                  "214",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: width * 0.0534722321),
                ),
              ),
              SizedBox(
                width: width * 0.0101851871,
              ),
              Container(
                child: Text(
                  'Win',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: width * 0.033101858),
                ),
              )
            ],
          ),
          Divider(
            thickness: 4,
          ),
          Row(
            children: [
              Container(
                width: width * 0.331,
                height: width * 0.076388903,
                child: Text(
                  "277",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: width * 0.0534722321),
                ),
              ),
              SizedBox(
                width: width * 0.0101851871,
              ),
              Container(
                child: Text(
                  'Played',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: width * 0.033101858),
                ),
              )
            ],
          ),
        ],
      ),
    );
    Widget b = (Container(
      key: Key('2'),
      width: width * 0.458,
      child: Column(
        key: ValueKey(0),
        children: [
          Row(
            children: [
              Container(
                  width: width * 0.331,
                  height: width * 0.076388903,
                  child: Shimmer.fromColors(
                      period: Duration(milliseconds: 6000),
                      child: Text(
                        "25",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.0712963095),
                      ),
                      baseColor: Colors.blue.shade900,
                      highlightColor: Colors.blue.shade400)),
              SizedBox(
                width: width * 0.0101851871,
              ),
              Container(
                child: Text(
                  'Rank',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: width * 0.033101858),
                ),
              )
            ],
          ),
          Divider(
            thickness: 4,
          ),
          Row(
            children: [
              Container(
                width: width * 0.331,
                height: width * 0.076388903,
                child: Text(
                  "156",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: width * 0.0534722321),
                ),
              ),
              SizedBox(
                width: width * 0.0101851871,
              ),
              Container(
                child: Text(
                  'Succes',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: width * 0.033101858),
                ),
              )
            ],
          ),
          Divider(
            thickness: 4,
          ),
          Row(
            children: [
              Container(
                width: width * 0.331,
                height: width * 0.076388903,
                child: Text(
                  "577",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: width * 0.0534722321),
                ),
              ),
              SizedBox(
                width: width * 0.0101851871,
              ),
              Container(
                child: Text(
                  'Hosted',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: width * 0.033101858),
                ),
              )
            ],
          ),
        ],
      ),
    ));
    Widget player = Container(
        padding: EdgeInsets.all(3),
        alignment: Alignment.center,
        child: Shimmer.fromColors(
            child: Text(
              "Player",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            baseColor: Colors.green,
            highlightColor: Colors.green.shade300));
    Widget hoster = Container(
        padding: EdgeInsets.all(3),
        alignment: Alignment.center,
        child: Shimmer.fromColors(
            child: Text(
              "Hoster",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            baseColor: Colors.blue,
            highlightColor: Colors.blue.shade300));

    Widget playerTier = Column(
      key: Key('3'),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.white),
              borderRadius: BorderRadius.circular(width * 0.030555555)),
          child: Container(
              padding: EdgeInsets.all(width * 0.015277777),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              child: Text('Player Tier ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: width * 0.043))),
        ),
        Container(
          child: Stack(
            children: [
              Center(
                child: Image(
                  width: width * 0.5092,
                  height: width * 0.5092,
                  image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/gamerstreet-40220.appspot.com/o/levels%2Fbronze.png?alt=media&token=e179f656-60e4-4751-9482-a1fa89c54833'),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 4,
                bottom: MediaQuery.of(context).size.width / 9.6,
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      'IV',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: width * 0.0636),
                    )),
              ),
            ],
          ),
        ),
        Container(
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                'Bronze ',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: width * 0.0636),
              )),
        )
      ],
    );
    Widget hosterTier = Column(
      key: Key('4'),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.white),
              borderRadius: BorderRadius.circular(width * 0.030555555)),
          child: Container(
              padding: EdgeInsets.all(width * 0.015277777),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              child: Text('Hoster Tier ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: width * 0.043))),
        ),
        Container(
          child: Stack(
            children: [
              Center(
                child: Image(
                  width: width * 0.5092,
                  height: width * 0.5092,
                  image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/gamerstreet-40220.appspot.com/o/levels%2Fbronze.png?alt=media&token=e179f656-60e4-4751-9482-a1fa89c54833'),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 4,
                bottom: MediaQuery.of(context).size.width / 9.6,
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      'V',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: width * 0.0636),
                    )),
              ),
            ],
          ),
        ),
        Container(
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                'Gold ',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: width * 0.0636),
              )),
        )
      ],
    );
    Widget onPlayer = InkWell(
      key: Key('5'),
      splashColor: Colors.black,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width * 0.04328),
          topLeft: Radius.circular(width * 0.04328)),
      onTap: () {
        {
          showAnimatedDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actionsPadding: EdgeInsets.all(0),
                insetPadding: EdgeInsets.all(0),
                // title: Text("Alert Dialog Box"),
                content: Container(
                  height: width * 0.95,
                  width: width * 0.8,
                  child: PlayedList(),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("okay"),
                  ),
                ],
              );
            },
            animationType: DialogTransitionType.slideFromRightFade,
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 500),
          );
        }
      },
      child: Container(
        height: width * 0.1273,
        margin: EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white10,
              Colors.yellow.shade600,
              Colors.yellow.shade700,
              Colors.yellow.shade800,
              Colors.yellow.shade900,
            ]),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * 0.04328),
                bottomLeft: Radius.circular(width * 0.04328)),
            border: Border.all(width: width * 0.0050926)),
        width: (MediaQuery.of(context).size.width / 2) - 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: width * 0.02546),
                width: width * 0.0763903,
                height: width * 0.0763903,
                alignment: Alignment.center,
                child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/gamerstreet-40220.appspot.com/o/levels%2Fgames.gif?alt=media&token=00636ead-29f7-461b-8249-4b0a1720d4a2')),
            SizedBox(
              width: width * 0.01273,
            ),
            Container(
              alignment: Alignment.center,
              width: width * 0.33102,
              child: Text(
                ' Played',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: width * 0.0518,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );

    Widget onHoster = InkWell(
      key: Key('6'),
      splashColor: Colors.black,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width * 0.04328),
          topLeft: Radius.circular(width * 0.04328)),
      onTap: () {
        {
          showAnimatedDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actionsPadding: EdgeInsets.all(0),
                insetPadding: EdgeInsets.all(0),
                // title: Text("Alert Dialog Box"),
                content: Container(
                  height: width * 0.95,
                  width: width * 0.8,
                  child: PlayedList(),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("okay"),
                  ),
                ],
              );
            },
            animationType: DialogTransitionType.slideFromRightFade,
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 500),
          );
        }
      },
      child: Container(
        height: width * 0.1273,
        margin: EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white10,
              Colors.yellow.shade600,
              Colors.yellow.shade700,
              Colors.yellow.shade800,
              Colors.yellow.shade900,
            ]),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * 0.04328),
                bottomLeft: Radius.circular(width * 0.04328)),
            border: Border.all(width: width * 0.0050926)),
        width: (MediaQuery.of(context).size.width / 2) - 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: width * 0.02546),
                width: width * 0.0763903,
                height: width * 0.0763903,
                alignment: Alignment.center,
                child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/gamerstreet-40220.appspot.com/o/levels%2Fgames.gif?alt=media&token=00636ead-29f7-461b-8249-4b0a1720d4a2')),
            SizedBox(
              width: width * 0.01273,
            ),
            Container(
              alignment: Alignment.center,
              width: width * 0.33102,
              child: Text(
                ' Hosted',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: width * 0.0518,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );

    return Stack(
      children: [
        Container(
            padding: EdgeInsets.only(bottom: 72),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: theme ? Colors.white : Colors.black,
                          border: Border.all(width: 2, color: Colors.black
                              //theme ? Colors.black : Colors.white,
                              ),
                          borderRadius:
                              BorderRadius.circular(width * 0.0763903035),
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 0, vertical: width * 0.0509259354),
                        margin: EdgeInsets.only(
                            top: width * 0.0509259354,
                            bottom: width * 0.0509259354,
                            left: width * 0.0203703741,
                            right: width * 0.0203703741),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: (width / 2) / 3.5,
                                  child: ClipRRect(
                                    child: Image.network(
                                        'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1085&q=80'),
                                    borderRadius: BorderRadius.circular(
                                        (width / 2) / 3.5),
                                  ),
                                ),
                                flag ? player : hoster,
                              ],
                            ),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 500),
                              reverseDuration: Duration(microseconds: 100),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return SizeTransition(
                                  axis: Axis.horizontal,
                                  sizeFactor: animation,
                                  //scale: animation,
                                  child: child,
                                );
                              },
                              child: flag ? a : b,
                            )
                          ],
                        ),
                      ),
                      phone.isEmpty
                          ? Container(
                              // padding: EdgeInsets.only(
                              //     top: width * 0.00509259354,
                              //     bottom: width * 0.00127314838),
                              width: double.infinity,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 20),
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Center(
                                  child: Shimmer.fromColors(
                                      direction: ShimmerDirection.rtl,
                                      period: Duration(milliseconds: 400),
                                      child: Text(
                                        'Verify your phone number immediately...',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.0381944505),
                                      ),
                                      baseColor:
                                          theme ? Colors.black : Colors.white,
                                      highlightColor: Colors.red),
                                ),
                              ),
                              //],
                              // ),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      // SizedBox(
                      //   height: width * 0.0509259354,
                      // ),
                      Container(
                        margin: EdgeInsets.all(1),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.black),
                            gradient: RadialGradient(
                                colors: [Colors.white, Colors.black])),
                        child: Stack(
                          children: [
                            Center(
                              child: Shimmer.fromColors(
                                  period: Duration(milliseconds: 2300),
                                  child: Container(
                                    margin: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color: Colors.black,
                                    ),
                                  ),
                                  baseColor: Colors.black,
                                  highlightColor: Colors.black12),
                            ),
                            Center(
                                child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 400),
                              reverseDuration: Duration(microseconds: 100),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                // return SizeTransition(
                                //   axis: Axis.horizontal,
                                //   sizeFactor: animation,
                                //   //scale: animation,
                                //   child: child,
                                // );
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(offsetSlide, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                              child: flag ? playerTier : hosterTier,
                            )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.black,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(width * 0.06620),
                                topRight: Radius.circular(width * 0.06620)),
                            onTap: () {
                              {
                                showAnimatedDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      actionsPadding: EdgeInsets.all(0),
                                      insetPadding: EdgeInsets.all(0),
                                      // title: Text("Alert Dialog Box"),
                                      content: Container(
                                        height: width * 0.95,
                                        width: width * 0.8,
                                        child: PlayedList(),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("okay"),
                                        ),
                                      ],
                                    );
                                  },
                                  animationType:
                                      DialogTransitionType.slideFromLeft,
                                  curve: Curves.fastOutSlowIn,
                                  duration: Duration(seconds: 1),
                                );
                              }
                            },
                            child: Container(
                              height: width * 0.1018,
                              margin: EdgeInsets.only(left: 2),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.yellow.shade900,
                                    Colors.yellow.shade800,
                                    Colors.yellow.shade700,
                                    Colors.yellow.shade600,
                                    Colors.white10,
                                  ]),
                                  borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(width * 0.06620),
                                      bottomRight:
                                          Radius.circular(width * 0.06620)),
                                  border: Border.all(width: width * 0.005092)),
                              width: MediaQuery.of(context).size.width / 2 -
                                  (2 + (width * 0.025463)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: width * 0.33102,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Season',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: width * 0.0458,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.012731,
                                  ),
                                  Container(
                                    width: width * 0.06336,
                                    height: width * 0.06336,
                                    margin: EdgeInsets.only(
                                        right: width * 0.020370),
                                    alignment: Alignment.center,
                                    child: Image.network(
                                        'https://firebasestorage.googleapis.com/v0/b/gamerstreet-40220.appspot.com/o/levels%2Fseason.gif?alt=media&token=e424117d-e7dc-4ba9-b642-4778c5f5402a'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.025463,
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 500),
                            reverseDuration: Duration(microseconds: 100),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                //axis: Axis.horizontal,
                                //sizeFactor: animation,
                                scale: animation,
                                child: child,
                              );
                            },
                            child: flag ? onPlayer : onHoster,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
        Positioned(
          //top: 100,
          bottom: 0,
          child: Container(
            height: 70,
            width: width,
            child: BottomNavigationBar(
                backgroundColor: Colors.white,
                // fixedColor: Colors.white,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    backgroundColor: theme ? Colors.white : Colors.black,
                    icon: flag
                        ? Icon(Icons.videogame_asset_rounded,
                            size: 32,
                            color: theme ? Colors.green : Colors.white)
                        : Icon(Icons.videogame_asset_outlined,
                            size: 32,
                            color: theme ? Colors.black : Colors.white),
                    title: Text(
                      'Player',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: theme ? Colors.black : Colors.white),
                    ),
                    // label: 'Player',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: theme ? Colors.white : Colors.black,
                    icon: flag
                        ? Icon(Icons.home_outlined,
                            size: 32,
                            color: theme ? Colors.black : Colors.white)
                        : Icon(Icons.home,
                            size: 32,
                            color: theme ? Colors.blue : Colors.white),
                    title: Text(
                      'Hoster',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: theme ? Colors.black : Colors.white),
                    ),
                  ),
                ],
                type: BottomNavigationBarType.shifting,
                currentIndex: bIndex,
                selectedItemColor: Colors.black,
                iconSize: 40,
                onTap: (index) {
                  if (index == 1) {
                    setState(() {
                      flag = false;
                      bIndex = 1;
                      offsetSlide = 1;
                    });
                  } else
                    setState(() {
                      flag = true;
                      bIndex = 0;
                      offsetSlide = -1;
                    });
                },
                elevation: 20),
          ),
        )
        // Positioned(
        //   left: _offset.dx,
        //   top: _offset.dy,
        //   child: Listener(
        //     onPointerMove: (PointerMoveEvent pointerMoveEvent) {
        //       _updatePosition(pointerMoveEvent);

        //       setState(() {
        //         _isDragging = true;
        //       });
        //     },
        //     onPointerUp: (PointerUpEvent pointerUpEvent) async {
        //       double height = MediaQuery.of(context).size.height;
        //       print(height);
        //       print(_offset.dy);
        //       print('onPointerUp');
        //       if (_offset.dx < (width / 2) - 30) {
        //         if (_offset.dy > height - 180) {
        //           setState(() {
        //             _offset = Offset(10, height - 180);
        //           });
        //         } else if (_offset.dy < 0) {
        //           setState(() {
        //             _offset = Offset(10, 10);
        //           });
        //         } else {
        //           setState(() {
        //             _offset = Offset(10, _offset.dy);
        //           });
        //         }
        //       } else {
        //         if (_offset.dy > height - 180) {
        //           setState(() {
        //             _offset = Offset(width - 65, height - 180);
        //           });
        //         } else if (_offset.dy < 0) {
        //           setState(() {
        //             _offset = Offset(width - 65, 10);
        //           });
        //         } else {
        //           setState(() {
        //             _offset = Offset(width - 65, _offset.dy);
        //           });
        //         }
        //       }
        //       SharedPreferences prefs = await SharedPreferences.getInstance();
        //       await prefs.setDouble('Dx', _offset.dx);
        //       await prefs.setDouble('Dy', _offset.dy);
        //       if (_isDragging) {
        //         setState(() {
        //           _isDragging = false;
        //         });
        //       } else {
        //         // widget.onPressed();
        //         // setState(() {
        //         //   flag = !flag;
        //         // });
        //       }
        //     },
        //     child: FloatingActionButton(
        //         backgroundColor: Colors.white,
        //         autofocus: true,
        //         focusColor: Colors.black,
        //         elevation: 200,
        //         onPressed: () {
        //           setState(() {
        //             flag = !flag;
        //           });
        //         },
        //         child: Stack(
        //           children: [
        //             Container(
        //               height: 17,
        //               width: 17,
        //               margin: EdgeInsets.all(3.7),
        //               decoration: BoxDecoration(
        //                 shape: BoxShape.circle,
        //                 color: Colors.white,
        //               ),
        //             ),
        //             Container(
        //               width: 17.5,
        //               height: 17.5,
        //               alignment: Alignment.center,
        //               decoration: BoxDecoration(
        //                 shape: BoxShape.circle,
        //               ),
        //               child: Icon(
        //                 Icons.change_circle_sharp,
        //                 size: 17.5,
        //                 color: flag ? Colors.blue : Colors.green,
        //               ),
        //             ),
        //             Container(
        //                 height: 40,
        //                 width: 54,
        //                 margin: EdgeInsets.only(left: 2, top: 7, bottom: 7),
        //                 alignment: Alignment.center,
        //                 child: Row(
        //                   children: [
        //                     flag
        //                         ? Container(
        //                             width: 40,
        //                             child: Text(
        //                               'Hoster',
        //                               textAlign: TextAlign.left,
        //                               style: TextStyle(
        //                                   letterSpacing: 0.0,
        //                                   fontWeight: FontWeight.bold,
        //                                   fontSize: 13,
        //                                   color: Colors.black),
        //                             ),
        //                           )
        //                         : Container(
        //                             width: 40,
        //                             child: Text(
        //                               'Player',
        //                               textAlign: TextAlign.left,
        //                               style: TextStyle(
        //                                   letterSpacing: 0.0,
        //                                   fontWeight: FontWeight.bold,
        //                                   fontSize: 13,
        //                                   color: Colors.black),
        //                             ),
        //                           ),
        //                     Container(
        //                         height: 14,
        //                         width: 14,
        //                         child: Shimmer.fromColors(
        //                             period: Duration(milliseconds: 150),
        //                             direction: ShimmerDirection.ltr,
        //                             child: Icon(
        //                               Icons.double_arrow,
        //                               size: 14,
        //                               color: flag ? Colors.blue : Colors.green,
        //                             ),
        //                             baseColor:
        //                                 flag ? Colors.blue : Colors.green,
        //                             highlightColor: Colors.white10))
        //                   ],
        //                 )),
        //             Container(
        //               width: double.infinity,
        //               margin: EdgeInsets.all(7),
        //               padding: EdgeInsets.only(right: 0),
        //               alignment: Alignment.centerRight,
        //               child: Column(
        //                 children: [
        //                   Transform.rotate(
        //                     angle: 315 * pi / 180,
        //                     child: Icon(
        //                       Icons.double_arrow,
        //                       size: 14,
        //                       color: flag ? Colors.blue : Colors.green,
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 13,
        //                   ),
        //                   Transform.rotate(
        //                     angle: 45 * pi / 180,
        //                     child: Icon(
        //                       Icons.double_arrow,
        //                       size: 14,
        //                       color: flag ? Colors.blue : Colors.green,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             )
        //           ],
        //         )
        //         ),
        //   ),
        // ),
      ],
    );
  }
}
