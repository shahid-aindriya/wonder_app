import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/add_invoice/controllers/add_invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice/model/invoice_data.dart';

import '../../../data/urls.dart';
import 'package:http/http.dart' as http;

import '../model/wallet_screen_model.dart';

class InvoiceController extends GetxController {
  final AddInvoiceController addInvoiceController =
      Get.put(AddInvoiceController());
  //TODO: Implement InvoiceController

  final count = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  var invoiceLists = RxList<InvoiceDatum>().obs;
  var invoiceListsForDropDown = RxList<InvoiceDatum>().obs;
  var amountDataList = RxList<AmountData>().obs;
  getInvoiceLists() async {
    // try {
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
      invoiceLists.value.addAll(invoiceData.invoiceData);
      invoiceListsForDropDown.value.assignAll(invoiceData.invoiceData);
    }
    // } catch (e) {
    //   log(e.toString());
    // }
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
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-invoice-filter-by-shop/"),
        headers: headers,
        body: jsonEncode(body));

    final requests = await http.post(
        Uri.parse("${baseUrl.value}shop-wallet-transactions/"),
        headers: headers,
        body: jsonEncode(body));
    if (request.statusCode == 201) {
      invoiceLists.value.clear();
      final invoiceData = invoiceDataFromJson(request.body);
      invoiceLists.value.addAll(invoiceData.invoiceData);
      update();
    }
    if (requests.statusCode == 201) {
      final walletScreenModel = walletScreenModelFromJson(requests.body);
      walletTransactionLists.assignAll(walletScreenModel.transactionData);
      walletAmount.value = walletScreenModel.shopWalletAmount;
    }
    log(requests.body);
  }

  notifications() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {"user_id": userId};
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-notifications/"),
        headers: headers,
        body: jsonEncode(body));
    log(request.body);
  }
}
