import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/add_invoice/controllers/add_invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice/model/invoice_data.dart';

import '../../../data/urls.dart';
import 'package:http/http.dart' as http;

import '../../invoice_details/models/invoice_approval_model.dart';
import '../../profile_view/model/userdata_response.dart';
import '../model/verified_model.dart';
import '../model/wallet_screen_model.dart';

class InvoiceController extends GetxController {
  final AddInvoiceController addInvoiceController =
      Get.put(AddInvoiceController());
  //TODO: Implement InvoiceController

  final count = 0.obs;
  @override
  void onInit() {
    pushFCMtoken();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    razorpay2.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay2.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay2.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    razorpay3.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess3);
    razorpay3.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError3);
    razorpay3.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet3);
    // TODO: implement onInit
    super.onInit();
  }

  final razorpay2 = Razorpay();
  final razorpay3 = Razorpay();
  @override
  void dispose() {
    razorpay.clear();
    razorpay2.clear();
    razorpay3.clear();
    checkButton.value = false;
    selecteddCommission.value = 0;
    selecteddCommissionCount.value = 0;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void onClose() {
    checkButton.value = false;
    selecteddCommission.value = 0;
    selecteddCommissionCount.value = 0;
  }

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
    walletTransactionLists.clear();
    var body = {"shop_id": id};
    log("haii $id");
    walletAmount.value = '';
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
      log(requests.body);
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
        walletAmount.value = walletScreenModel.shopWalletAmount.toString();
        update();
      }
      log(requests.body);
    } catch (e) {
      // Get.snackbar("Error", "Something went wrong",
      //     backgroundColor: Colors.red);
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
      // log(requests.body);
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
        walletAmount.value = walletScreenModel.shopWalletAmount.toString();
        update();
      }
    } catch (e) {
      // Get.snackbar("Error", "Something went wrong",
      //     backgroundColor: Colors.red);
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
      // log(request.body);
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
              ) ||
          index.invoiceDate.toString().contains(
                value.toLowerCase(),
              ) ||
          index.phone.toString().contains(
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
      // Get.snackbar("Error", "Something went wrong",
      //     backgroundColor: Colors.red);
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

  RxList<VerifiedInvoiceData> verifiedList = <VerifiedInvoiceData>[].obs;
  RxList<TotalAmountData> verifiedAmountData = <TotalAmountData>[].obs;
  RxList<bool> checkBoxedList = <bool>[].obs;
  var verifiedAmount = ''.obs;
  Future<bool> verifiedInvoiceList() async {
    var body = {"shop_id": selectShopId};

    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-verified-invoice-list/"),
        body: jsonEncode(body));
    log(request.body.toString());
    if (request.statusCode == 201) {
      final verfiedModel = verfiedModelFromJson(request.body);
      verifiedList.assignAll(verfiedModel.invoiceData);
      verifiedAmountData.assign(verfiedModel.totalAmountData);
      checkBoxedList = RxList.filled(verifiedList.length, false);
      update();
      return true;
    }
    return false;
  }

  var isVerifyLoading = false.obs;
  approveOrDeclineInvoice({
    choice,
    invoiceId,
    context,
  }) async {
    log(invoiceId.toString());
    var body = {"invoice_id": invoiceId, "status": choice};
    try {
      isVerifyLoading.value = true;
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-invoice-status-change/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body.toString());
      if (request.statusCode == 201) {
        final invoiceApprovalModel = invoiceApprovalModelFromJson(request.body);
        if (invoiceApprovalModel.success == true) {
          await verifiedInvoiceList();
          await onPullRefreshInWallet();
          isVerifyLoading.value = false;
          MotionToast.success(
            dismissable: true,
            enableAnimation: false,
            position: MotionToastPosition.top,
            title: const Text(
              'Succes ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            description: Text('Invoice ${choice}d successfully'),
            animationCurve: Curves.bounceIn,
            borderRadius: 0,
            animationDuration: const Duration(milliseconds: 1000),
          ).show(context);

          MotionToast.success(
            dismissable: true,
            enableAnimation: false,
            position: MotionToastPosition.top,
            title: const Text(
              'Succes ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            description: Text('Invoice ${choice}d successfully'),
            animationCurve: Curves.bounceIn,
            borderRadius: 0,
            animationDuration: const Duration(milliseconds: 1000),
          ).show(context);
        } else {
          isVerifyLoading.value = false;
          MotionToast.error(
            dismissable: true,
            enableAnimation: false,
            position: MotionToastPosition.top,
            title: const Text(
              'Error ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            description: Text('Something went wrong or No sufficient balance'),
            animationCurve: Curves.bounceIn,
            borderRadius: 0,
            animationDuration: const Duration(milliseconds: 1000),
          ).show(context);
        }
      }
    } catch (e) {
      isVerifyLoading.value = false;
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  final razorpay = Razorpay();
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _showSnackBar("SUCCESS: ${response.paymentId}", id: response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _showSnackBar(
      "ERROR: ${response.code} - ${response.message}",
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    _showSnackBar("EXTERNAL_WALLET: ${response.walletName!}");
  }

  openCheckout(
      {razorKey, amount, invoiceId, name, email, required dynamic data}) async {
    if (data.haveBank == false) {
      Get.snackbar("Error", "No bank Account Found to current shop ",
          backgroundColor: Colors.red);
      return;
    } else {
      log(amount.toString());
      var amt = amount * 100;
      var options = {
        "key": razorKey,
        "amount": amt,
        "name": name,
        "description": "Test Transaction",
        "prefill": {"contact": "9123456789", "email": email},
        "external": {
          "wallets": ["paytm", "googlepay"]
        },
      };

      try {
        razorpay.open(options);
      } catch (e) {
        log(e.toString());
      }
    }
  }

  var isLoading = false.obs;
  void _showSnackBar(String message, {id}) async {
    // Get.snackbar("Info ", message, backgroundColor: Colors.amber);
    log(message);
    if (id != null) {
      isLoading.value = true;
      await paymentSuccess(razorId: id);
      isLoading.value = false;
    }
  }

  dynamic invoiceId;
  dynamic amount;
  paymentSuccess({
    razorId,
  }) async {
    var body = {
      "invoice_id": invoiceId,
      "amount": amount,
      "razorpay_transaction_id": razorId,
      "razorpay_status": "completed"
    };
    try {
      isVerifyLoading.value = true;
      final requests = await http.post(
          Uri.parse("${baseUrl.value}vendor-invoice-payment-success/"),
          headers: headers,
          body: jsonEncode(body));
      log(requests.body.toString());
      if (requests.statusCode == 201) {
        Get.snackbar("Info ", "Payment completed succesfully",
            backgroundColor: Colors.green);
        await verifiedInvoiceList();
        await onPullRefreshInWallet();
        isVerifyLoading.value = false;
        return;
      } else if (requests.statusCode == 500) {
        Get.snackbar("Error ", "Something went wrong",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error ", "Something went wrong",
          backgroundColor: Colors.red);
      isLoading.value = false;
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    showSnackBar("SUCCESS: ${response.paymentId}", id: response.paymentId);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    showSnackBar(
      "ERROR: ${response.code} - ${response.message}",
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    showSnackBar("EXTERNAL_WALLET: ${response.walletName!}");
  }

  openCheckoutForAllPay(
      {razorKey, amounts, name, email, phone, required dynamic data}) async {
    if (data.haveBank == false) {
      Get.snackbar("Error", "No bank Account Found to current shop ",
          backgroundColor: Colors.red);
      return;
    } else {
      num amt = amounts * 100;

      log("hai${amt.toString()}");
      var options = {
        "key": razorKey,
        "amount": amt.toInt(),
        "name": name,
        "description": " Transaction",
        "prefill": {"contact": phone, "email": email},
        "external": {
          "wallets": ["paytm", "googlepay"]
        },
      };

      try {
        razorpay2.open(options);
      } catch (e) {
        log(e.toString());
      }
    }
  }

  void showSnackBar(String message, {id}) async {
    // Get.snackbar("Info ", message, backgroundColor: Colors.amber);
    log(message);
    if (id != null) {
      isLoading.value = true;
      await paymentSuccessForAll(razorId: id);
      isLoading.value = false;
    }
  }

  dynamic shopId;
  dynamic fullAmount;
  paymentSuccessForAll({
    razorId,
  }) async {
    var body = {
      "shop_id": selectShopId,
      "amount": fullAmount,
      "razorpay_transaction_id": razorId,
      "razorpay_status": "completed"
    };
    try {
      isVerifyLoading.value = true;
      final requests = await http.post(
          Uri.parse("${baseUrl.value}vendor-shop-pay-amount/"),
          headers: headers,
          body: jsonEncode(body));
      log(requests.body.toString());
      if (requests.statusCode == 201) {
        Get.snackbar("Info ", "Payment completed succesfully",
            backgroundColor: Colors.green);
        await verifiedInvoiceList();
        await onPullRefreshInWallet();
        isVerifyLoading.value = false;
        return;
      } else if (requests.statusCode == 500) {
        Get.snackbar("Error ", "Something went wrong",
            backgroundColor: Colors.red);
        isVerifyLoading.value = false;
      }
    } catch (e) {
      Get.snackbar("Error ", "Something went wrong",
          backgroundColor: Colors.red);
      isLoading.value = false;
    }
  }

  var checkButton = false.obs;
  RxDouble selecteddCommission = 0.0.obs;
  RxInt selecteddCommissionCount = 0.obs;
  List<double> selectedAmountList = [];
  RxDouble totalSelectedCommissionAmount = 0.0.obs;
  checBoxFunct(value, index, commissionAmount, walletAmount) {
    checkBoxedList[index] = value!;
    if (value == true) {
      selecteddCommission.value = selecteddCommission.value + commissionAmount;

      selecteddCommissionCount.value++;
      update();
    } else {
      selecteddCommission.value = selecteddCommission.value - commissionAmount;

      selecteddCommissionCount.value--;
      update();
    }
    totalSelectedCommissionAmount.value = 0;
    if (selecteddCommission.value > walletAmount) {
      totalSelectedCommissionAmount.value =
          selecteddCommission.value - walletAmount;
    }

    log(selecteddCommission.value.toString());
    log(walletAmount.toString());
    update();
  }

  openCheckoutForAllPay3(
      {razorKey, amounts, name, email, phone, required dynamic data}) async {
    if (data.haveBank == false) {
      Get.snackbar("Error", "No bank Account Found to current shop ",
          backgroundColor: Colors.red);
      return;
    } else {
      log(amount.toString());
      var amt = amounts * 100;
      var options = {
        "key": razorKey,
        "amount": amt,
        "name": name,
        "description": " Transaction",
        "prefill": {"contact": phone, "email": email},
        "external": {
          "wallets": ["paytm", "googlepay"]
        },
      };

      try {
        razorpay3.open(options);

        update();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  void handlePaymentSuccess3(PaymentSuccessResponse response) {
    showSnackBar3("SUCCESS: ${response.paymentId}", id: response.paymentId);
  }

  void handlePaymentError3(PaymentFailureResponse response) {
    showSnackBar3(
      "ERROR: ${response.code} - ${response.message}",
    );
  }

  void handleExternalWallet3(ExternalWalletResponse response) {
    showSnackBar3("EXTERNAL_WALLET: ${response.walletName!}");
  }

  void showSnackBar3(String message, {id}) async {
    // Get.snackbar("Info ", message, backgroundColor: Colors.amber);
    log(message);
    if (id != null) {
      isLoading.value = true;
      await paymentSuccessForAll3(razorId: id);
      isLoading.value = false;
    }
  }

  paymentSuccessForAll3({
    razorId,
  }) async {
    log(selecteddCommission.value.toString());
    var body = {
      "shop_id": selectShopId,
      "amount": totalSelectedCommissionAmount.value,
      "razorpay_transaction_id": razorId,
      "razorpay_status": "completed"
    };
    try {
      isVerifyLoading.value = true;
      final requests = await http.post(
          Uri.parse("${baseUrl.value}vendor-shop-pay-amount/"),
          headers: headers,
          body: jsonEncode(body));
      log(requests.statusCode.toString());
      if (requests.statusCode == 201) {
        Get.snackbar("Info ", "Payment completed succesfully",
            backgroundColor: Colors.green);
        selecteddCommission.value = 0;
        await verifiedInvoiceList();
        await onPullRefreshInWallet();
        isVerifyLoading.value = false;
        selecteddCommission.value = 0;
        totalSelectedCommissionAmount.value = 0;
        checkButton.value = false;
        checkBoxedList = RxList.filled(checkBoxedList.length, false);
        return;
      } else if (requests.statusCode == 500) {
        Get.snackbar("Error ", "Something went wrong",
            backgroundColor: Colors.red);
        isVerifyLoading.value = false;
        selecteddCommission.value = 0;
        totalSelectedCommissionAmount.value = 0;
        checkButton.value = false;
        checkBoxedList = RxList.filled(checkBoxedList.length, false);
      }
    } catch (e) {
      Get.snackbar("Error ", "Something went wrong",
          backgroundColor: Colors.red);
      isLoading.value = false;
      selecteddCommission.value = 0;
      totalSelectedCommissionAmount.value = 0;
      checkButton.value = false;
      checkBoxedList = RxList.filled(checkBoxedList.length, false);
    }
  }
}
