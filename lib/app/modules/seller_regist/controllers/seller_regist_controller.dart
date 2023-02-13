import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class SellerRegistController extends GetxController {
  //TODO: Implement SellerRegistController
  String adhaarimg = '';
  File? image;
  pickimage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();
      final compressedimage = testComporessList(bytes);
      adhaarimg = base64Encode(await compressedimage);
    }
    // log(img);
    update();
  }

  String panimg = '';
  File? image3;
  pickimage2() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pimage == null) {
      return;
    } else {
      image3 = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();
      final compressedimage = testComporessList(bytes);
      panimg = base64Encode(await compressedimage);
    }
    // log(panimg);
    update();
  }

  snackBar(context) {
    MotionToast.warning(
      dismissable: true,
      enableAnimation: false,
      position: MotionToastPosition.top,
      title: const Text(
        'Warning ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text('Please fill all fields'),
      animationCurve: Curves.bounceIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 1000),
    ).show(context);
  }

  testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 600,
      minWidth: 400,
      quality: 100,
      format: CompressFormat.png,
      rotate: 0,
    );
    log(list.length.toString());
    log(result.length.toString());
    return result.toList();
  }
}
