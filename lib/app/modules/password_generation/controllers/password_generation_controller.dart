import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';
import 'package:wonder_app/app/modules/request_pending/views/request_pending_view.dart';

import '../../../../api/api_service.dart';
import '../model/response_model.dart';

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

  sellerRegister(
      {name,
      phone,
      email,
      adhaar,
      pan,
      password,
      adarImag,
      panImag,
      context}) async {
    var body = {
      "name": name,
      "phone": phone,
      "email": email,
      "adar_number": adhaar,
      "pan_number": pan,
      "auto_password": isOn.value,
      "password": password,
      "adar_image": adarImag,
      "pan_image": panImag
    };

    final request = await _apiService.post("/vendor-register/", body);

    final sellerRegistrationResponse =
        sellerRegistrationResponseFromJson(request);
    log(request.toString());
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
    } else if (sellerRegistrationResponse.isApproved == false) {
      Get.to(RequestPendingView());
    } else {
      Get.to(InvoiceView());
    }
  }
}
