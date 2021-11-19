import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class GetImage {
  static Future<File?> pickMedia({
    required bool isGallery,
    required Future<File?> Function(File file) cropImage,
  }) async {
    final source = isGallery ? ImageSource.gallery : ImageSource.camera;
    final pickedFile = await ImagePicker().pickImage(
        source: source, imageQuality: 100, maxWidth: 500, maxHeight: 500);
    if (pickedFile == null) {
      return null;
    } else {
      final file = File(pickedFile.path);
      return cropImage(file);
    }
  }
}
