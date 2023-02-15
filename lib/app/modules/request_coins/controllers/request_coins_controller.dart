import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../../data/urls.dart';

class RequestCoinsController extends GetxController {
  //TODO: Implement RequestCoinsController

  final count = 0.obs;

  void increment() => count.value++;
  dynamic selectShopId;
  changeShop({dynamic value, id}) {
    log(value.toString());
    selectShopId = null;

    selectShopId = value;

    update();
  }

  requestCoins({int? userId, int? amount, context}) async {
    {
      var body = {
        "shop_id": selectShopId,
        "user_id": userId,
        "amount": amount,
      };
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-request-coin/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body.toString());
      if (request.statusCode == 201) {
        final rquestData = jsonDecode(request.body);
        if (rquestData['success'] == true) {
          Get.back();
          selectShopId = null;
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
        } else {
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
        // log(shopsListModel.shopData[0].licenseImage.toString());
      } else {
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
}
