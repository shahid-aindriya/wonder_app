import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationDetailsController extends GetxController {
  //TODO: Implement RegistrationDetailsController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;

  String licenceImage = '';
  File? image;
  pickimage(bool value) async {
    try {
      final pimage = await ImagePicker().pickImage(
          source: value == true ? ImageSource.camera : ImageSource.gallery);
      if (pimage == null) {
        return;
      } else {
        image = File(pimage.path);

        final bytes = File(pimage.path).readAsBytesSync();
        final compressedImage = testComporessList(bytes);
        licenceImage = base64Encode(await compressedImage);
      }
      // log(img);
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  testComporessList(Uint8List list) async {
    log(list.length.toString());
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 400,
      minWidth: 400,
      quality: 100,
      format: CompressFormat.jpeg,
      rotate: 0,
    );

    log(result.length.toString());
    return result.toList();
  }

  showPopup(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a photo'),
                  onTap: () {
                    pickimage(true);
                    // Handle the 'Take a photo' option
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Choose from gallery'),
                  onTap: () {
                    pickimage(false);
                    // Handle the 'Choose from gallery' option
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
