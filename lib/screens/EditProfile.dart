import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:gamer_street/Widgets/GetImage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  final String profileUrl;
  const EditProfile({Key? key, required this.profileUrl}) : super(key: key);
  static const Editprofile = '/EditProfile-widget';
  @override
  _FutureDataState createState() => _FutureDataState();
}

class _FutureDataState extends State<EditProfile> {
  Future<DocumentSnapshot> getUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: FutureBuilder(
          future: getUserData(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Colors.black,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              var doc = snapshot.data as DocumentSnapshot;
              return FutureData(
                doc: doc,
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text("No Data Found"),
                ),
              );
            }
          }),
    );
  }
}

class FutureData extends StatefulWidget {
  final DocumentSnapshot doc;
  const FutureData({Key? key, required this.doc}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<FutureData> {
  var imageIs;
  bool image = false;
  Future<File?> _cropImage(File imageFile) async {
    return await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square]);
  }

  String urlp = '';
  bool changed = false;
  bool isLoading = false;
  void initState() {
    super.initState();
    urlp = widget.doc.get('profileUrl').toString();
  }

  void uploadImagetoFireBase(File file) async {
    setState(() {
      isLoading = true;
    });
    final ref = FirebaseStorage.instance
        .ref()
        .child('users')
        .child(FirebaseAuth.instance.currentUser!.uid + ".jpg");

    await ref.putFile(file).then((p0) async {
      final url = await ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profileUrl': value});
        setState(() {
          urlp = value;
          isLoading = false;
        });
      });
    });
  }

  bool onPhoto = false;
  @override
  Widget build(BuildContext context) {
    Widget b = SizedBox(
      height: 0,
      width: 0,
    );
    Widget a = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          reverseDuration: Duration(microseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          child: onPhoto
              ? Container(
                  width: (MediaQuery.of(context).size.width / 3) - 3.4,
                  padding: EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                      ),
                      color: onPhoto ? Colors.black : null),
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: TextButton.icon(
                      style: TextButton.styleFrom(primary: Colors.white),
                      onPressed: () {
                        GetImage.pickMedia(
                                isGallery: true, cropImage: _cropImage)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              imageIs = value;
                              image = true;
                              onPhoto = !onPhoto;
                              uploadImagetoFireBase(value);
                            });
                          }
                        });
                      },
                      icon: Icon(Icons.image_rounded),
                      label: Text("Gallery")))
              : b,
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          reverseDuration: Duration(microseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          child: onPhoto
              ? Container(
                  width: (MediaQuery.of(context).size.width / 3) - 3.3,
                  padding: EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(),
                      color: onPhoto ? Colors.black : null),
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: TextButton.icon(
                      style: TextButton.styleFrom(primary: Colors.white),
                      onPressed: () {
                        GetImage.pickMedia(
                                isGallery: false, cropImage: _cropImage)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              imageIs = value;
                              image = true;
                              onPhoto = !onPhoto;
                              uploadImagetoFireBase(value);
                            });
                          }
                        });
                      },
                      icon: Icon(Icons.camera),
                      label: Text("Camera")))
              : b,
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          reverseDuration: Duration(microseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          child: onPhoto
              ? Container(
                  width: (MediaQuery.of(context).size.width / 3) - 3.4,
                  padding: EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                      color: onPhoto ? Colors.black : null),
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: TextButton.icon(
                      style: TextButton.styleFrom(primary: Colors.white),
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                          imageIs = "";
                          image = true;
                          onPhoto = !onPhoto;
                        });
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({'profileUrl': ""});
                        setState(() {
                          urlp = "";
                          isLoading = false;
                        });
                      },
                      icon: Icon(Icons.hide_image_outlined),
                      label: Text("Remove")))
              : b,
        ),
      ],
    );

    return Stack(
      children: [
        SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 75,
                        child: ClipRRect(
                          child:
                              widget.doc.get('profileUrl').toString().isNotEmpty
                                  ? Image.network(
                                      urlp,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Icon(Icons.videogame_asset);
                                      },
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Icon(
                                        Icons.person_rounded,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                          borderRadius: BorderRadius.circular(75),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            setState(() {
                              onPhoto = !onPhoto;
                            });
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                  color: onPhoto ? Colors.black : null),
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Edit Profile Photo",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: onPhoto ? Colors.white : null),
                              )),
                        ),
                        a,
                      ],
                    ),
                  ],
                ))),
        isLoading
            ? Container(
                color: Colors.black54,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 5,
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
