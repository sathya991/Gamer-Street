import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamer_street/Widgets/GetImage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class Screenshots extends StatefulWidget {
  const Screenshots({Key? key}) : super(key: key);

  @override
  _ScreenshotsState createState() => _ScreenshotsState();
}

class _ScreenshotsState extends State<Screenshots> {
  Future<File?> _cropImage(File imageFile) async {
    return await ImageCropper.cropImage(sourcePath: imageFile.path,

        // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.original]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Upload Winner screenshot here",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () {
                  GetImage.pickMedia(isGallery: true, cropImage: _cropImage);
                },
                splashColor: Colors.red,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.black12,
                  child: Icon(Icons.add_a_photo_outlined),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text("Upload 2nd Runner screenshot here",
                      style: TextStyle(fontWeight: FontWeight.w900)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                splashColor: Colors.red,
                onTap: () {
                  GetImage.pickMedia(isGallery: true, cropImage: _cropImage);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.black12,
                  child: Icon(Icons.add_a_photo_outlined),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text("Upload 3rd Runner screenshot here",
                      style: TextStyle(fontWeight: FontWeight.w900)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                splashColor: Colors.red,
                onTap: () {
                  GetImage.pickMedia(isGallery: true, cropImage: _cropImage);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.black12,
                  child: Icon(Icons.add_a_photo_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
