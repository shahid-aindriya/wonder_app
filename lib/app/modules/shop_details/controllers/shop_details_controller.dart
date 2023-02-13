import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/urls.dart';

class ShopDetailsController extends GetxController {
  //TODO: Implement ShopDetailsController

  final count = 0.obs;

  void increment() => count.value++;

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
}
