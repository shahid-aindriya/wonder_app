import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/urls.dart';
import '../model/shops_list_model.dart';

class MyShopsController extends GetxController {
  //TODO: Implement MyShopsController

  final count = 0.obs;

  void increment() => count.value++;
  List<double> rating1 = [0.0, 0.0, 0.0, 0.0];

  void starRating(index, rating) {
    rating1[index] = rating;
    update();
  }

  RxList<ShopDatum> shopLists = <ShopDatum>[].obs;

  Future<dynamic> getListOfShops() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    if (userId == null) {
      log("message");
    } else {
      var body = {"user_id": userId.toString()};
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-all-shop/"),
          headers: headers,
          body: jsonEncode(body));
      // log(request.body.toString());
      if (request.statusCode == 201) {
        final shopsListModel = shopsListModelFromJson(request.body);
        // log(shopsListModel.shopData[0].licenseImage.toString());
        shopLists.assignAll(shopsListModel.shopData);
        return shopsListModel.shopData;
      }
    }
  }
}
