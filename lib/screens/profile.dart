import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final String profileUrl;
  const Profile({Key? key, required this.profileUrl}) : super(key: key);
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
  void initState() {
    super.initState();
    getsUserData();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  String profileUrl = '';
  Future<DocumentSnapshot> getUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.profileUrl)
        .get();
  }

  String username = '';
  void getsUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.profileUrl)
        .get()
        .then((value) {
      setState(() {
        username = value.get('userName');
        profileUrl = value.get('profileUrl');
        // print(profileUrl + "ggggggggggggggg");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool theme = Provider.of<ThemeProvider>(context).getThemeForProfile();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: theme ? Colors.black : Colors.white,
        backgroundColor: theme ? Colors.white : Colors.black,
        title: Text(username),
        actions: [
          widget.profileUrl == FirebaseAuth.instance.currentUser!.uid
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(SlideRightRoute(
                        page: EditProfile(
                      profileUrl: profileUrl,
                    )));
                    // Navigator.pushNamed(context, CustomPageRoute(child: EditProfile.Editprofile));
                  },
                  icon: Icon(Icons.edit))
              : SizedBox()
        ],
      ),
      body: FutureBuilder(
          future: Future.wait([
            getUserData(),
            buildPotrait(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if ((snapshot.hasData)) {
              var i = (snapshot.data! as dynamic)[0];

              //  username = (i as DocumentSnapshot).get('userName');

              return Profilerender(
                doc: i,
                passedUrl: widget.profileUrl,
              );
            } else {
              return Text('No data');
            }
          }),
    );
  }
}

class Profilerender extends StatefulWidget {
  final DocumentSnapshot doc;
  final String passedUrl;
  const Profilerender({Key? key, required this.doc, required this.passedUrl})
      : super(key: key);

  @override
  _ProfilerenderState createState() => _ProfilerenderState();
}

class _ProfilerenderState extends State<Profilerender> {
  int bIndex = 0;
  double offsetSlide = 1;

  void initState() {
    super.initState();
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
                        widget.doc.get('playerRank').toString(),
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
                  widget.doc.get('gamesWon').toString(),
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
                  widget.doc.get('gamesPlayed').toString(),
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
                        widget.doc.get('hosterRank').toString(),
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
                  widget.doc.get('hostSuccess').toString(),
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
                  widget.doc.get('gamesHosted').toString(),
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
              child: Text('Player Tier',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: width * 0.043))),
        ),
        Container(
          child: Stack(
            children: [
              Center(
                child: widget.doc.get('playerTierUrl').toString().isNotEmpty
                    ? Image.network(
                        widget.doc.get('playerTierUrl').toString(),
                        width: width * 0.5092,
                        height: width * 0.5092,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Icon(Icons.videogame_asset);
                        },
                      )
                    : Container(
                        width: width * 0.5092,
                        height: width * 0.5092,
                      ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 4,
                bottom: MediaQuery.of(context).size.width / 9.6,
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      widget.doc.get('playerTierNo').toString(),
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
                widget.doc.get('playerTier').toString(),
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
                child: widget.doc.get('hosterTierUrl').toString().isNotEmpty
                    ? Image.network(
                        widget.doc.get('hosterTierUrl').toString(),
                        width: width * 0.5092,
                        height: width * 0.5092,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Icon(Icons.videogame_asset);
                        },
                      )
                    : Container(
                        width: width * 0.5092,
                        height: width * 0.5092,
                      ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 4,
                bottom: MediaQuery.of(context).size.width / 9.6,
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      widget.doc.get('hosterTierNo').toString(),
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
                widget.doc.get('hosterTier').toString(),
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
                                    child: widget.doc
                                            .get('profileUrl')
                                            .toString()
                                            .isNotEmpty
                                        ? Image.network(
                                            widget.doc
                                                .get('profileUrl')
                                                .toString(),
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Icon(
                                                  Icons.videogame_asset);
                                            },
                                          )
                                        : ClipRect(
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black,
                                              child: Icon(
                                                Icons.videogame_asset,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
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
                      FirebaseAuth.instance.currentUser!.uid == widget.passedUrl
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: width * 0.025463,
                                ),
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 500),
                                  reverseDuration: Duration(microseconds: 100),
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
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
                          : SizedBox()
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
        //                   Transform.rotate(+

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
