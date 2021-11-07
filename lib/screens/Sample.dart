import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:gamer_street/Widgets/PlayedList.dart';
import 'package:flutter/services.dart';

class Sample extends StatefulWidget {
  const Sample({Key? key}) : super(key: key);
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  Future<int> buildPotrait() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return 1;
  }

  bool flag = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('data'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              flag = !flag;
            });
          },
          child: Icon(Icons.ac_unit),
        ),
        body: FutureBuilder(
            future: buildPotrait(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 3),
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
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: (width / 2) / 3.5,
                            child: ClipRRect(
                              child: Image.network(
                                  'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1085&q=80'),
                              borderRadius:
                                  BorderRadius.circular((width / 2) / 3.5),
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 4000),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            // child: a,
                            child: flag
                                ? Container(
                                    height: 100,
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
                                                    period: Duration(
                                                        milliseconds: 6000),
                                                    child: Text(
                                                      "9",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: width *
                                                              0.0712963095),
                                                    ),
                                                    baseColor:
                                                        Colors.green.shade900,
                                                    highlightColor:
                                                        Colors.green.shade400)),
                                            SizedBox(
                                              width: width * 0.0101851871,
                                            ),
                                            Container(
                                              child: Text(
                                                'Rank',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        width * 0.033101858),
                                              ),
                                            )
                                          ],
                                        ),
                                        Divider(
                                          thickness: 4,
                                        ),
                                        Row(
                                          // mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: width * 0.331,
                                              height: width * 0.076388903,
                                              child: Text(
                                                "214",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize:
                                                        width * 0.0534722321),
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
                                                    fontSize:
                                                        width * 0.033101858),
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
                                                    fontSize:
                                                        width * 0.0534722321),
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
                                                    fontSize:
                                                        width * 0.033101858),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 100,
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
                                                    period: Duration(
                                                        milliseconds: 6000),
                                                    child: Text(
                                                      "9",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: width *
                                                              0.0712963095),
                                                    ),
                                                    baseColor:
                                                        Colors.green.shade900,
                                                    highlightColor:
                                                        Colors.green.shade400)),
                                            SizedBox(
                                              width: width * 0.0101851871,
                                            ),
                                            Container(
                                              child: Text(
                                                'Rank',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        width * 0.033101858),
                                              ),
                                            )
                                          ],
                                        ),
                                        Divider(
                                          thickness: 4,
                                        ),
                                        Row(
                                          // mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: width * 0.331,
                                              height: width * 0.076388903,
                                              child: Text(
                                                "214",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize:
                                                        width * 0.0534722321),
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
                                                    fontSize:
                                                        width * 0.033101858),
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
                                                    fontSize:
                                                        width * 0.0534722321),
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
                                                    fontSize:
                                                        width * 0.033101858),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: width * 0.00509259354,
                              bottom: width * 0.00127314838),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: width * 0.076388903,
                                width: width * 0.076388903,
                                child: FaIcon(
                                  FontAwesomeIcons.gamepad,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.0254629677,
                              ),
                              Text(
                                'sasi.bhumaraju@gmail.com',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.0381944505),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: width * 0.00509259354,
                          bottom: width * 0.00127314838),
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: width * 0.076388903,
                            width: width * 0.076388903,
                            child: FaIcon(
                              FontAwesomeIcons.phoneSquareAlt,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.0254629677,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                '+91 7680898988',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.0381944505),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width * 0.0509259354,
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
                            child: Image(
                              width: width * 0.5092,
                              height: width * 0.5092,
                              image: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/gamerstreet-40220.appspot.com/o/levels%2Fbronze.png?alt=media&token=e179f656-60e4-4751-9482-a1fa89c54833'),
                            ),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width / 4,
                            bottom: MediaQuery.of(context).size.width / 3,
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
                          Positioned(
                            left: MediaQuery.of(context).size.width / 4,
                            bottom: MediaQuery.of(context).size.width / 8,
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
                                    // title: Text("Alert Dialog Box"),
                                    content: Container(
                                      height: double.infinity,
                                      width: 300,
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
                                    topRight: Radius.circular(width * 0.06620),
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
                                  margin:
                                      EdgeInsets.only(right: width * 0.020370),
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
                        InkWell(
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
                                animationType:
                                    DialogTransitionType.slideFromRightFade,
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
                                    bottomLeft:
                                        Radius.circular(width * 0.04328)),
                                border: Border.all(width: width * 0.0050926)),
                            width: (MediaQuery.of(context).size.width / 2) - 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin:
                                        EdgeInsets.only(left: width * 0.02546),
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
                                        fontSize: width * 0.0518,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else {
                return Text('data');
              }
            }));
  }
}
