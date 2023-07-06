import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/data/urls.dart';

import '../model/bank_transaction_model.dart';

class BankTransactionsController extends GetxController {
  //TODO: Implement BankTransactionsController

  final count = 0.obs;

  void increment() => count.value++;
  RxList<TransactionDatum> transactionData = <TransactionDatum>[].obs;
  bankTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    final body = {"user_id": userId};
    final request = await post(
        Uri.parse("${baseUrl.value}vendor-bank-transactions/"),
        body: jsonEncode(body),
        headers: headers.value);
    log(request.body);
    if (request.statusCode == 201) {
      final bankTransactionModel = bankTransactionModelFromJson(request.body);
      transactionData.assignAll(bankTransactionModel.transactionData);
      update();
    }
  }
}
