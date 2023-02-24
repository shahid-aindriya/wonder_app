import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/add_invoice/controllers/add_invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice/model/invoice_data.dart';

import '../../../data/urls.dart';
import 'package:http/http.dart' as http;

import '../../profile_view/model/userdata_response.dart';
import '../model/wallet_screen_model.dart';

class InvoiceController extends GetxController {
  final AddInvoiceController addInvoiceController =
      Get.put(AddInvoiceController());
  //TODO: Implement InvoiceController

  final count = 0.obs;
  @override
  void onInit() {
    pushFCMtoken();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  var invoiceLists = RxList<InvoiceDatum>().obs;
  var invoiceListsFilter = RxList<InvoiceDatum>().obs;
  var amountDataList = RxList<AmountData>().obs;

  dynamic selectShopId;
  getInvoiceLists() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt("userId");
      var body = {
        "user_id": userId,
      };
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-invoice-list/"),
          headers: headers,
          body: jsonEncode(body));

      log(request.statusCode.toString());
      if (request.statusCode == 201) {
        invoiceLists.value.clear();
        final invoiceData = invoiceDataFromJson(request.body);
        // invoiceLists.value.addAll(invoiceData.invoiceData);
        invoiceListsFilter.value.assignAll(invoiceData.invoiceData);
        // selectShopId = invoiceLists.value.first.id;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  changeShop({dynamic value, id}) {
    log(value.toString());
    selectShopId = null;

    selectShopId = value;

    update();
  }
  // RxList<AmountData> amountdataList = <AmountData>[].obs;
  // invoiceDetails({int? invoiceId}) async {
  //   var body = {"invoice_id": invoiceId};

  //   var request = await http.post(
  //       Uri.parse("${baseUrl.value}vendor-invoice-details/"),
  //       headers: headers,
  //       body: jsonEncode(body));

  //   log(request.body.toString());
  //   if (request.statusCode == 201) {
  //     final invoiceDetailsResponse =
  //         invoiceDetailsResponseFromJson(request.body);
  //     amountdataList.assign(invoiceDetailsResponse.amountData);
  //   }
  // }
  RxList<TransactionDatum> walletTransactionLists = <TransactionDatum>[].obs;
  var walletAmount = "".obs;
  onDropDownChanged(id) async {
    var body = {"shop_id": id};
    // invoiceLists.value.clear();
    // invoiceLists.value
    //     .addAll(invoiceListsForDropDown.value.where((p0) => p0.shopId = int.tryParse(id)!));
    // update();
    try {
      final request = await http.post(
          Uri.parse("${baseUrl.value}vendor-invoice-filter-by-shop/"),
          headers: headers,
          body: jsonEncode(body));

      final requests = await http.post(
          Uri.parse("${baseUrl.value}shop-wallet-transactions/"),
          headers: headers,
          body: jsonEncode(body));
      if (request.statusCode == 201) {
        final invoiceData = invoiceDataFromJson(request.body);
        invoiceLists.value.assignAll(invoiceData.invoiceData);
        invoiceListsFilter.value.assignAll(invoiceData.invoiceData);
        filterListValue.value = "All";
        searchInvoiceList.clear();
        update();
      }
      if (requests.statusCode == 201) {
        final walletScreenModel = walletScreenModelFromJson(requests.body);
        walletTransactionLists.assignAll(walletScreenModel.transactionData);
        walletAmount.value = walletScreenModel.shopWalletAmount;
        update();
      }
      log(request.body);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  onPullRefreshInWallet() async {
    var body = {"shop_id": selectShopId};
    try {
      final request = await http.post(
          Uri.parse("${baseUrl.value}vendor-invoice-filter-by-shop/"),
          headers: headers,
          body: jsonEncode(body));
      final requests = await http.post(
          Uri.parse("${baseUrl.value}shop-wallet-transactions/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body);
      if (request.statusCode == 201) {
        invoiceLists.value.clear();
        final invoiceData = invoiceDataFromJson(request.body);
        invoiceLists.value.addAll(invoiceData.invoiceData);
        invoiceListsFilter.value.assignAll(invoiceData.invoiceData);
        filterListValue.value = "All";
        searchInvoiceList.clear();
        update();
      }
      if (requests.statusCode == 201) {
        final walletScreenModel = walletScreenModelFromJson(requests.body);
        walletTransactionLists.assignAll(walletScreenModel.transactionData);
        walletAmount.value = walletScreenModel.shopWalletAmount;
        update();
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  notifications() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    try {
      var body = {"user_id": userId};
      final request = await http.post(
          Uri.parse("${baseUrl.value}vendor-notifications/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  RxList<dynamic> filterList = ['All', 'Approved', 'Pending', 'Rejected'].obs;
  var filterListValue = 'All'.obs;
  onFilterListChange(value) {
    invoiceLists.value.clear();
    if (value == "All") {
      invoiceLists.value.assignAll(invoiceListsFilter.value);
    } else if (value == "Approved") {
      invoiceLists.value.assignAll(
          invoiceListsFilter.value.where((p0) => p0.status == "Approve"));
    } else if (value == "Pending") {
      invoiceLists.value.assignAll(
          invoiceListsFilter.value.where((p0) => p0.status == "Pending"));
    } else {
      invoiceLists.value.assignAll(
          invoiceListsFilter.value.where((p0) => p0.status == "Reject"));
    }
  }

  RxList<InvoiceDatum> searchInvoiceList = <InvoiceDatum>[].obs;
  searchInvoiceResults(String value) {
    searchInvoiceList.clear();
    for (var index in invoiceListsFilter.value) {
      if (index.invoiceNumber.toString().contains(
            value.toLowerCase(),
          )) {
        InvoiceDatum data = InvoiceDatum(
            id: index.id,
            customerId: index.customerId,
            customerName: index.customerName,
            phone: index.phone,
            userId: index.userId,
            shopId: index.shopId,
            userImage: index.userImage,
            vendorImage: index.vendorImage,
            invoiceImage: index.invoiceImage,
            invoiceNumber: index.invoiceNumber,
            invoiceDate: index.invoiceDate,
            preTaxAmount: index.preTaxAmount,
            invoiceAmount: index.invoiceAmount,
            remark: index.remark,
            status: index.status,
            myself: index.myself,
            amountData: index.amountData);
        searchInvoiceList.add(data);
      }
    }
  }

  RxList<UserData> userDetailLists = <UserData>[].obs;

  Future<dynamic> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {"user_id": userId};
    try {
      final request = await http.post(
          Uri.parse("${baseUrl.value}vendor-profile-view/"),
          headers: headers,
          body: jsonEncode(body));
      // log("sdfgsdfgs${request.body}");
      if (request.statusCode == 201) {
        final userDataResponse = userDataResponseFromJson(request.body);
        userDetailLists.assign(userDataResponse.userData);

        update();
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void pushFCMtoken() async {
    try {
      String? token = await messaging.getToken();

      log("token:$token");
      print("hello");
      await sendDeviceToken(token!);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  Future<void> sendDeviceToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");

    try {
      var response = await post(
        Uri.parse('${baseUrl.value}vendor-update-device-token/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{"user_id": userId, "device_token": token}),
      );
      log('status${response.statusCode}');

      if (response.statusCode == 201) {
        print("got token");
        print(response.statusCode);
      } else {
        throw Exception("failed to send token");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }
}
