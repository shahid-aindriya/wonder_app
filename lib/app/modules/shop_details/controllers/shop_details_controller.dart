import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/my_shops/controllers/my_shops_controller.dart';

import '../../../data/urls.dart';
import '../model/offer_data_response.dart';

class ShopDetailsController extends GetxController {
  //TODO: Implement ShopDetailsController

  final count = 0.obs;

  void increment() => count.value++;
  dynamic shopId;
  editShopDetails({shopId, shopImage, gstImage, licenceImage}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {
      "shop_id": shopId,
      "name": "abc",
      "user_id": userId,
      "category_id": 1,
      "gst_number": "32435345",
      "address": "dassdv dfvddfgd",
      "location": "Ernakulam, Kerala, India",
      "latitude": "9.9816358",
      "longitude": "76.2998842",
      "radius": "50",
      "commission": "10",
      "gst_pct": "10",
      "license_number": "987654567",
      "featured_image": shopImage,
      "gst_image": gstImage,
      "license_image": licenceImage,
      "is_featured": "True"
    };
    var request = await http.post(
        Uri.parse("${baseUrl.value}vendor-edit-shop/"),
        headers: headers,
        body: jsonEncode(body));
  }

  deleteShop({bankid, MyShopsController? controller, context}) async {
    var body = {"bank_id": bankid};
    var request = await http.post(
        Uri.parse("${baseUrl.value}vendor-delete-shop/"),
        headers: headers,
        body: jsonEncode(body));
    log(request.body);
    if (request.statusCode == 201) {
      final data = jsonDecode(request.body);
      if (data['success'] == true) {
        await controller!.getListOfShops();
        Get.back();
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
          description: const Text('Deleted Succesfully'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
    }
  }

  RxList<OfferDatum> offerdatas = <OfferDatum>[].obs;
  getOffers() async {
    var body = {"shop_id": shopId};
    var request = await http.post(
        Uri.parse("${baseUrl.value}vendor-get-all-shop-offers/"),
        headers: headers,
        body: jsonEncode(body));
    log(request.body);
    if (request.statusCode == 201) {
      final offerDataResponse = offerDataResponseFromJson(request.body);
      offerdatas.assignAll(offerDataResponse.offerData);
    }
  }

  String offerImage = '';
  File? image;
  dynamic compressedImage;

  pickimage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();

      compressedImage = testComporessList(bytes);
      offerImage = base64Encode(await compressedImage);
      // log(invoiceImg);
    }
    // log(img);
    update();
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

  addOffers({name, shopId, discount, descpition, context}) async {
    log(shopId.toString());
    var body = {
      "name": name,
      "shop_id": shopId,
      "discount": discount,
      "description": descpition,
      "image": offerImage
    };
    var request = await http.post(
        Uri.parse("${baseUrl.value}vendor-add-shop-offer/"),
        headers: headers,
        body: jsonEncode(body));
    log(request.body.toString());
    if (request.statusCode == 201) {
      final datas = jsonDecode(request.body);
      if (datas['success'] == true) {
        await getOffers();
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
          description: const Text('offer added Succesfully'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
    }
  }
}
