import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:wonder_app/app/data/urls.dart';

import '../model/business_rep_model.dart';

class SellerRegistController extends GetxController {
  //TODO: Implement SellerRegistController

  final selectedDiscountValue = 0.obs;

  String adhaarimg = '';
  XFile? image;
  pickimage(bool value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      // image = File(pimage.path);
      log(pimage.path);
      final ims = await cropsImage(pimage.path);

      final bytes = File(ims.path).readAsBytesSync();
      final compressedimage = testComporessList(bytes);
      adhaarimg = base64Encode(await compressedimage);
    }
    log("hai");
    update();
  }

  String panimg = '';
  File? image3;
  pickimage2(bool value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      final ims = await cropsImage(pimage.path);

      final bytes = File(ims.path).readAsBytesSync();
      final compressedimage = testComporessList(bytes);
      panimg = base64Encode(await compressedimage);
    }
    log("panimg");
    update();
  }

  String tanImg = '';
  File? image4;
  pickimage3(bool value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      final ims = await cropsImage(pimage.path);

      final bytes = File(ims.path).readAsBytesSync();
      final compressedimage = testComporessList(bytes);
      tanImg = base64Encode(await compressedimage);
    }
    log("panimg");
    update();
  }

  snackBar({required context, required text}) {
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
      description: Text(text),
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
      format: CompressFormat.jpeg,
      rotate: 0,
    );
    log(list.length.toString());
    log(result.length.toString());
    return result.toList();
  }

  showPopup(contexts, {value}) {
    showModalBottomSheet(
      context: contexts,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a photo'),
                  onTap: () {
                    if (value == true) {
                      pickimage(true);
                    } else if (value == false) {
                      pickimage2(true);
                    } else {
                      pickimage3(true);
                    }
                    // Handle the 'Take a photo' option
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Choose from gallery'),
                  onTap: () {
                    value == true
                        ? pickimage(false)
                        : value == false
                            ? pickimage2(false)
                            : pickimage3(false);
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

  CroppedFile? _croppedFile;
  Future<dynamic> cropsImage(path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      _croppedFile = croppedFile;
      return _croppedFile;
    } else {
      return;
    }
  }

  bool isChecked = false;
  dynamic selectRepId;
  checkBox(value) {
    isChecked = value;
    if (value == false) {
      selectRepId = null;
    }
    update();
  }

  RxList<ListBusinessRep> repsList = <ListBusinessRep>[].obs;
  getReps() async {
    final request = await http
        .get(Uri.parse("${baseUrl.value}all-business-rep/"), headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      final businessRepModel = businessRepModelFromJson(request.body);
      repsList.assignAll(businessRepModel.listBusinessRep);
    }
  }

  changeRadioVal(value) {
    if (value != null) {
      selectedDiscountValue.value = value;
      update();
    }
  }

  getVendors(email) async {
    log(email);
    final body = {"vendor_email": email};
    final request = await http.post(
        Uri.parse("${baseUrl.value}list-all-has-child-vendors/"),
        headers: headers.value,
        body: jsonEncode(body));
    log(request.body);
  }
}
