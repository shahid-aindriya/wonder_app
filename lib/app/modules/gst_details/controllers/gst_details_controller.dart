import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/bank_details/views/bank_details_view.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';

import '../../../data/urls.dart';
import '../model/shop_add_response.dart';

class GstDetailsController extends GetxController {
  //TODO: Implement GstDetailsController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  dynamic compressedImage;
  String gstImage = '';
  File? image;
  pickimage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();
      compressedImage = testComporessList(bytes);
      gstImage = base64Encode(await compressedImage);
    }
    // log(img);
    update();
  }

  addShopToServer(
      {shopName,
      closingTime,
      openingTime,
      userId,
      categoryId,
      shopImage,
      licenseImage,
      address,
      location,
      commission,
      licenceNumber,
      gstNumber,
      gstPercentage,
      featured,
      context}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {
      "name": shopName,
      "user_id": userId,
      "category_id": categoryId,
      "gst_number": gstNumber,
      "address": address,
      "latitude": "9.9816358",
      "longitude": "76.2998842",
      "opening_time": openingTime,
      "closing_time": closingTime,
      "location": location,
      "is_featured": featured,
      "commission": commission,
      "image": gstImage,
      "gst_pct": gstPercentage,
      "license_number": licenceNumber,
      "gst_image": gstImage,
      "license_image": gstImage
    };
    var request = await http.post(Uri.parse("${baseUrl.value}vendor-add-shop/"),
        headers: headers, body: jsonEncode(body));
    log(request.body.toString());

    if (request.statusCode == 201) {
      final addshopresponse = addshopresponseFromJson(request.body);
      final shopId = addshopresponse.shopId;
      if (addshopresponse.success == true) {
        Get.off(BankDetailsView(
          shopId: shopId,
        ));
        MotionToast.success(
          dismissable: true,
          enableAnimation: false,
          position: MotionToastPosition.top,
          title: const Text(
            'Success ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          description: const Text('Shop Added Succesfully'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      } else {
        Get.offAll(InvoiceView());
        MotionToast.error(
          dismissable: true,
          enableAnimation: false,
          position: MotionToastPosition.top,
          title: const Text(
            'Error ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          description: const Text('Something went wrong'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
    }
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
