import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/invoice/model/invoice_data.dart';

import '../../../data/urls.dart';
import 'package:http/http.dart' as http;

import '../../invoice_details/models/invoice_details_response.dart';

class InvoiceController extends GetxController {
  //TODO: Implement InvoiceController

  final count = 0.obs;
  @override
  void onInit() {
    getInvoiceLists();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  var invoiceLists = RxList<dynamic>().obs;
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

    log(request.body);
    if (request.statusCode == 201) {
      final invoiceData = invoiceDataFromJson(request.body);
      invoiceLists.value.assignAll(invoiceData.invoiceData);
    }
    // } catch (e) {
    //   log(e.toString());
    // }
  }

  RxList<AmountData> amountdataList = <AmountData>[].obs;
  invoiceDetails({int? invoiceId}) async {
    var body = {"invoice_id": 1};

    var request = await http.post(
        Uri.parse("${baseUrl.value}vendor-invoice-details/"),
        headers: headers,
        body: jsonEncode(body));
    log(request.statusCode.toString());
  }
}
