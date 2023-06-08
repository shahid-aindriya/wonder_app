import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/urls.dart';
import '../../my_shops/model/shops_list_model.dart';
import '../model/support_model.dart';

class SupportRequestController extends GetxController {
  //TODO: Implement SupportRequestController
  @override
  void onInit() {
    requestScrollController.addListener(requeseScroll);
    // TODO: implement onInit
    super.onInit();
  }

  final count = 0.obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  void increment() => count.value++;
  RxInt selectedIndex = (-1).obs;

  dynamic selectShopId;
  var shopLists = RxList<ShopDatum>().obs;
  changeShop({dynamic value, id}) {
    log(value.toString());
    selectShopId = null;

    selectShopId = value;

    update();
  }

  changeColor(index) {
    selectedIndex.value = index;
  }

  RxList<String> requesstList =
      <String>['All', 'Completed', 'Cancelled', 'Pending'].obs;

  Future<dynamic> getListOfShops() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {"user_id": userId.toString()};

    try {
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-all-shop/"),
          headers: headers,
          body: jsonEncode(body));
      // log(request.statusCode.toString());
      if (request.statusCode == 201) {
        final shopsListModel = shopsListModelFromJson(request.body);
        // log(shopsListModel.shopData[0].licenseImage.toString());
        shopLists.value.assignAll(shopsListModel.shopData);

        update();
        return shopsListModel.shopData;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  RxInt totalPage = 1.obs;
  var currentpage = 1.obs;
  RxList<SupportDatum> supportLists = <SupportDatum>[].obs;
  final requestScrollController = ScrollController();
  getRequests() async {
    if (currentpage.value > totalPage.value) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {"user_id": userId.toString(), "page": currentpage.value};

    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-list-support-request/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      final supportModel = supportModelFromJson(request.body);
      totalPage.value = supportModel.totalPages;
      if (currentpage.value == 1) {
        supportLists.assignAll(supportModel.supportData);
        update();
      } else {
        supportLists.addAll(supportModel.supportData);
      }
    }
  }

  var isRequestLoading = false.obs;
  Future<void> requeseScroll() async {
    if (requestScrollController.position.pixels ==
        requestScrollController.position.maxScrollExtent) {
      isRequestLoading.value = true;
      currentpage.value++;
      log("hai");
      await getRequests();
      isRequestLoading.value = false;
      update();
    }
  }

  var isAddRequest = false.obs;
  addRequest(context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    isAddRequest.value = true;
    var body = {
      "user_id": userId.toString(),
      "title": titleController.text,
      "description": descriptionController.text,
      "shop_id": selectShopId
    };

    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-add-support-request/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      final data = jsonDecode(request.body);
      if (data['success'] == true) {
        await getRequests();
        titleController.clear();
        descriptionController.clear();
        selectShopId = null;
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
          description: const Text('Support requested Succesfully'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
        isAddRequest.value = false;
      }
      isAddRequest.value = false;
    }
    isAddRequest.value = false;
  }
}
