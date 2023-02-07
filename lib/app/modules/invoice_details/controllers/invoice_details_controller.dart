import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../../data/urls.dart';

class InvoiceDetailsController extends GetxController {
  //TODO: Implement InvoiceDetailsController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;

  approveOrDeclineInvoice({choice, invoiceId, context}) async {
    var body = {"invoice_id": invoiceId, "status": choice};

    var request = await http.post(
        Uri.parse("${baseUrl.value}vendor-invoice-status-change/"),
        headers: headers,
        body: jsonEncode(body));
    log(request.body);
    if (request.statusCode == 201) {
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
        description: Text('Invoice $choice  Succesfully'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
    }
  }
}
