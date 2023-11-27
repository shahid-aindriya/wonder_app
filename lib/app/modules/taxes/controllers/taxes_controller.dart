import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';

import '../../../data/urls.dart';
import '../model/gst_model.dart';
import '../model/tds_model.dart';

class TaxesController extends GetxController {
  //TODO: Implement TaxesController

  final count = 0.obs;

  @override
  void onInit() {
    tdsScrollController.addListener(tdsScroll);
    gstScrollController.addListener(gstScroll);
    // TODO: implement onInit
    super.onInit();
  }

  void increment() => count.value++;
  RxList<AllDatum> tdsList = <AllDatum>[].obs;
  final totalTdsPages = 1.obs;
  final currentTdsPage = 1.obs;
  final tdsScrollController = ScrollController();

  getTds() async {
    if (currentTdsPage.value > totalTdsPages.value) {
      log("message");
      return;
    }
    final body = {
      "shop_id": invoiceController.selectShopId,
      "page": currentTdsPage.value
    };

    final request = await http.post(
        Uri.parse(
          "${baseUrl.value}shop-tds-data/",
        ),
        body: jsonEncode(body),
        headers: headers.value);
    log(request.body);
    if (request.statusCode == 201) {
      final tdsModel = tdsModelFromJson(request.body);
      totalTdsPages.value = tdsModel.totalPages;
      if (currentTdsPage.value == 1) {
        tdsList.assignAll(tdsModel.allData);
      } else {
        tdsList.addAll(tdsModel.allData);
      }
    }
  }

  var isTdsLoading = false.obs;
  Future<void> tdsScroll() async {
    if (tdsScrollController.position.pixels ==
        tdsScrollController.position.maxScrollExtent) {
      isTdsLoading.value = true;
      currentTdsPage.value++;
      log("hai");
      await getTds();
      isTdsLoading.value = false;
      update();
    }
  }

  RxList<AllDatum> gstList = <AllDatum>[].obs;
  final totalGstPages = 1.obs;
  final currentGstPage = 1.obs;
  final gstScrollController = ScrollController();

  getGst() async {
    if (currentGstPage.value > totalGstPages.value) {
      log("message");
      return;
    }
    final body = {"shop_id": invoiceController.selectShopId, "page": 1};

    final request = await http.post(
        Uri.parse(
          "${baseUrl.value}shop-gst-data/",
        ),
        body: jsonEncode(body),
        headers: headers.value);
    log(request.body);
    if (request.statusCode == 201) {
      final gstModel = gstModelFromJson(request.body);
      totalGstPages.value = gstModel.totalPages;
      if (currentGstPage.value == 1) {
        gstList.assignAll(gstModel.allData);
      }
    }
  }

  var isGstLoading = false.obs;
  Future<void> gstScroll() async {
    if (gstScrollController.position.pixels ==
        gstScrollController.position.maxScrollExtent) {
      isGstLoading.value = true;
      currentGstPage.value++;
      log("hai");
      await getGst();
      isGstLoading.value = false;
      update();
    }
  }
}
