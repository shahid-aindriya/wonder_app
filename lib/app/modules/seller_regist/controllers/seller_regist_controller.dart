import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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
      adhaarimg = base64Encode(bytes);
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
      panimg = base64Encode(bytes);
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
}
