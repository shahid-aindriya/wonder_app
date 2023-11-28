import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';

import '../model/my_earnings.dart';

final MyEarningsController myEarningsController =
    Get.put(MyEarningsController());

class MyEarningsController extends GetxController {
  //TODO: Implement MyEarningsController
  @override
  void onInit() {
    earningsScrollController.addListener(earningsScroll);
    // TODO: implement onInit
    super.onInit();
  }

  final count = 0.obs;

  void increment() => count.value++;

  RxList<TransactionDatum> earningslist = <TransactionDatum>[].obs;
  RxString totalAmount = "".obs;
  RxInt earningsTotalpage = 1.obs;
  var earningsCurrentpage = 1.obs;
  final earningsScrollController = ScrollController();
  getMyEarnings(id) async {
    if (earningsCurrentpage.value > earningsTotalpage.value) {
      return;
    }

    final body = {"shop_id": id, "page": earningsCurrentpage.value};

    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-shop-earnings/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      final myEarnings = myEarningsFromJson(request.body);
      totalAmount.value = myEarnings.shopEarnings.toString();
      earningsTotalpage.value = myEarnings.totalPages;
      if (earningsCurrentpage.value == 1) {
        earningslist.assignAll(myEarnings.transactionData);
      } else {
        earningslist.addAll(myEarnings.transactionData);
      }
    }
  }

  var isEarningsLoading = false.obs;
  Future<void> earningsScroll() async {
    if (earningsScrollController.position.pixels ==
        earningsScrollController.position.maxScrollExtent) {
      isEarningsLoading.value = true;
      earningsCurrentpage.value++;
      log("hai");
      await getMyEarnings(invoiceController.selectShopId);
      isEarningsLoading.value = false;
      update();
    }
  }
}
