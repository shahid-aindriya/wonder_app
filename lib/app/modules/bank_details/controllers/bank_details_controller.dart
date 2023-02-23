import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/success/views/success_view.dart';

import '../../../data/urls.dart';
import '../models/bank_add_response.dart';

class BankDetailsController extends GetxController {
  //TODO: Implement BankDetailsController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  String chequeImage = '';
  File? image;
  pickimage(value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();
      final compressedImage = testComporessList(bytes);
      chequeImage = base64Encode(await compressedImage);
    }
    // log(img);
    update();
  }

  testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 500,
      minWidth: 400,
      quality: 70,
      rotate: 0,
    );
    log(list.length.toString());
    log(result.length.toString());
    return result.toList();
  }

  addBankDetails({shopId, int? accountNum, accType, ifscCode, name}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    // log(name);
    // log(shopId);
    // log(accountNum.toString());
    // log(ifscCode);

    var body = {
      "name": name,
      "user_id": userId,
      "shop_id": shopId,
      "account_number": accountNum,
      "account_type": accType,
      "ifsc_code": ifscCode,
      "cheque_copy": chequeImage
    };
    var request = await http.post(Uri.parse("${baseUrl.value}vendor-add-bank/"),
        headers: headers, body: jsonEncode(body));
    log(request.body.toString());

    if (request.statusCode == 201) {
      final bankaddresponse = bankaddresponseFromJson(request.body);
      if (bankaddresponse.success == true) {
        Get.to(SuccessView());
      }
    }
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
