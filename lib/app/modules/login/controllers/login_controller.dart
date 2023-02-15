import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';
import 'package:wonder_app/app/modules/store_details/views/store_details_view.dart';

import '../../../data/urls.dart';
import '../../request_pending/views/request_pending_view.dart';
import '../models/login_respose_model.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final ApiService _apiService = Get.put(ApiService());
  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<dynamic> loginFunct({email, password, context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = {"email": email, "password": password};

    var request = await http.post(Uri.parse("${baseUrl.value}vendor-login/"),
        headers: headers, body: jsonEncode(body));
    log(request.body);

    if (request.statusCode == 201) {
      final loginResponseModel = loginResponseModelFromJson(request.body);

      if (loginResponseModel.isApproved == true &&
          loginResponseModel.haveShop == true) {
        prefs.setInt("userId", loginResponseModel.userId!);
        Get.offAll(InvoiceView());
        MotionToast.success(
          dismissable: true,
          enableAnimation: false,
          position: MotionToastPosition.top,
          title: const Text(
            'Welcome ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          description: const Text('Succesfully logged in'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      } else if (loginResponseModel.isApproved == true &&
          loginResponseModel.haveShop == false) {
        prefs.setInt("userId", loginResponseModel.userId!);
        Get.to(StoreDetailsView());
      } else if (loginResponseModel.isApproved == false) {
        Get.to(RequestPendingView());
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
          description: const Text('Email id not found'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
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
