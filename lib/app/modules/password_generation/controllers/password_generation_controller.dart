import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/request_pending/views/request_pending_view.dart';
import 'package:wonder_app/app/modules/store_details/views/store_details_view.dart';

import '../../../../api/api_service.dart';
import '../../../data/urls.dart';
import '../model/response_model.dart';
import 'package:http/http.dart' as http;

class PasswordGenerationController extends GetxController {
  //TODO: Implement PasswordGenerationController

  final ApiService _apiService = Get.put(ApiService());
  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  var selectedRadio = 0;
  var isOn = false.obs;
  setSelectedRadio() {
    isOn.value = !isOn.value;
    log(isOn.value.toString());
    update();
  }

  var isLoading = false.obs;
  sellerRegister(
      {name,
      phone,
      email,
      adhaar,
      pan,
      password,
      adarImag,
      panImag,
      context,
      repId}) async {
    var body = {
      "name": name,
      "phone": phone,
      "email": email,
      "adar_number": adhaar,
      "pan_number": pan,
      "auto_password": isOn.value,
      "password": password,
      "adar_image": adarImag,
      "pan_image": panImag,
      "business_rep_id": repId
    };

    try {
      isLoading.value = true;
      final request = await http.post(
          Uri.parse("${baseUrl.value}vendor-register/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body.toString());
      if (request.statusCode == 201) {
        final sellerRegistrationResponse =
            sellerRegistrationResponseFromJson(request.body);
        log(request.body.toString());
        if (sellerRegistrationResponse.success == false &&
            sellerRegistrationResponse.message == "Email already exist") {
          MotionToast.warning(
            position: MotionToastPosition.top,
            title: const Text(
              'Warning ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            description: const Text('Email already exist'),
            animationCurve: Curves.bounceIn,
            borderRadius: 0,
            animationDuration: const Duration(milliseconds: 1000),
          ).show(context);
          isLoading.value = false;
        } else if (sellerRegistrationResponse.isApproved == false) {
          Get.to(RequestPendingView());
          isLoading.value = false;
        } else {
          final prefs = await SharedPreferences.getInstance();
          prefs.setInt("userId", sellerRegistrationResponse.userId);
          Get.to(StoreDetailsView());
          isLoading.value = false;
        }
      } else if (request.statusCode == 403) {
        MotionToast.warning(
          position: MotionToastPosition.top,
          title: const Text(
            'Warning ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          description: const Text('Image Size too big '),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
        isLoading.value = false;
      } else if (request.statusCode == 500) {
        Get.snackbar("Error", "Something went wrong",
            backgroundColor: Colors.red);
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
