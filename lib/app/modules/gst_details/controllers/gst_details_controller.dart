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
import 'package:wonder_app/app/modules/store_details/controllers/store_details_controller.dart';

import '../../../data/urls.dart';
import '../model/shop_add_response.dart';

class GstDetailsController extends GetxController {
  //TODO: Implement GstDetailsController
  final StoreDetailsController storeDetailsController =
      Get.put(StoreDetailsController());
  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  dynamic compressedImage;
  String gstImage = '';
  File? image;
  pickimage(bool value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
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

  var isLoading = false.obs;
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
      lat,
      long,
      webSiteUrls,
      context}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    log(closingTime.toString());
    log(openingTime.toString());
    final gstImg = gstImage == '' ? null : gstImage;
    final licenceImg = licenseImage == '' ? null : licenseImage;
    var body = {
      "name": shopName,
      "user_id": userId,
      "category_id": categoryId,
      "gst_number": gstNumber,
      "address": address,
      "latitude": lat,
      "longitude": long,
      "opening_time": openingTime,
      "closing_time": closingTime,
      "location": location,
      "is_featured": featured,
      "commission": commission,
      "image": shopImage,
      "gst_pct": gstPercentage,
      "license_number": licenceNumber,
      "gst_image": gstImg,
      "license_image": licenceImg,
      "website_url": webSiteUrls
    };
    try {
      isLoading.value = true;
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-add-shop/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.statusCode.toString());

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
          storeDetailsController.shopImage = '';
          isLoading.value = false;
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
          isLoading.value = false;
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
      isLoading.value = false;
    }
    isLoading.value = false;
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
