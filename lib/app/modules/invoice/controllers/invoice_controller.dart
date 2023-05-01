import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/add_invoice/controllers/add_invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice/model/invoice_data.dart';

import 'package:http/http.dart' as http;
import 'package:wonder_app/app/modules/request_pending/views/request_pending_view.dart';

import '../../../data/urls.dart';
import '../../invoice_details/models/invoice_approval_model.dart';
import '../../profile_view/model/userdata_response.dart';
import '../model/search_invoice_model.dart';
import '../model/search_transaction_model.dart';
import '../model/verified_model.dart';
import '../model/wallet_screen_model.dart';

class InvoiceController extends GetxController {
  final AddInvoiceController addInvoiceController =
      Get.put(AddInvoiceController());
  //TODO: Implement InvoiceController

  final count = 0.obs;
  @override
  void onInit() {
    // pushFCMtoken();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    razorpay2.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay2.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay2.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    razorpay3.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess3);
    razorpay3.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError3);
    razorpay3.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet3);
    scrollController.addListener(scrollListner);
    walletScrollController.addListener(walletScroll);
    walletTransactionScrollController.addListener(walletTransactionScroll);
    invoiceScrollController.addListener(invoiceScroll);
    filterScrolController.addListener(filterScrollListener);
    dateRangeScrollController.addListener(dateRangeScrollListener);
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
  // getInvoiceLists() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final userId = prefs.getInt("userId");
  //     var body = {
  //       "user_id": userId,
  //     };
  //     var request = await http.post(
  //         Uri.parse("${baseUrl.value}vendor-invoice-list/"),
  //         headers: headers,
  //         body: jsonEncode(body));

  //     log(request.statusCode.toString());
  //     if (request.statusCode == 201) {
  //       invoiceLists.value.clear();
  //       final invoiceData = invoiceDataFromJson(request.body);
  //       // invoiceLists.value.addAll(invoiceData.invoiceData);
  //       invoiceListsFilter.value.assignAll(invoiceData.invoiceData);
  //       // selectShopId = invoiceLists.value.first.id;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  var isAddInvoiceTrue = false.obs;
  checkVerifiedVendor() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    final body = {"user_id": userId};
    final request = await http.post(
        Uri.parse("${baseUrl.value}check-vendor-add-invoice/"),
        body: jsonEncode(body),
        headers: headers);
    if (request.statusCode == 201) {
      log(request.body);
      final data = jsonDecode(request.body);
      if (data["add_invoice"] == true) {
        isAddInvoiceTrue.value = true;
        return;
      } else {
        isAddInvoiceTrue.value = false;
        return;
      }
    }
  }

  changeShop({dynamic value, id}) {
    log(value.toString());
    selectShopId = null;

    selectShopId = value;

    update();
  }

  final invoiceScrollController = ScrollController();
  final walletTransactionScrollController = ScrollController();
  RxList<TransactionDatum> walletTransactionLists = <TransactionDatum>[].obs;
  RxList<TransactionDatum> walletTransactionLists2 = <TransactionDatum>[].obs;

  RxInt walletTransactionTotalpage = 1.obs;
  var walletCurrentpage = 1.obs;

  var walletAmount = "".obs;
  onDropDownChanged(id) async {
    // walletTransactionLists.clear();
    // invoiceLists.value.clear();
    startDate = null;
    endDate = null;
    final entryType =
        debitListValue.value == "All" ? null : debitListValue.value;
    if (walletCurrentpage.value > walletTransactionTotalpage.value) {
      return;
    }
    var walletBody = {
      "shop_id": id,
      "page": walletCurrentpage.value,
      "entry_type": entryType
    };
    log("haii $id");
    walletAmount.value = '';

    try {
      final requests = await http.post(
          Uri.parse("${baseUrl.value}shop-wallet-transactions/"),
          headers: headers,
          body: jsonEncode(walletBody));
      log(requests.statusCode.toString());

      if (requests.statusCode == 201) {
        final walletScreenModel = walletScreenModelFromJson(requests.body);
        walletTransactionTotalpage.value = walletScreenModel.totalPages;
        walletAmount.value = walletScreenModel.shopWalletAmount.toString();

        if (walletCurrentpage.value == 1) {
          walletTransactionLists.assignAll(walletScreenModel.transactionData);
          walletTransactionLists2.assignAll(walletScreenModel.transactionData);

          searchWalletTransactionList.clear();
          await checkActiveUser();
          update();
        } else {
          walletTransactionLists.addAll(walletScreenModel.transactionData);
          walletTransactionLists2.addAll(walletScreenModel.transactionData);
          walletAmount.value = walletScreenModel.shopWalletAmount.toString();
          searchWalletTransactionList.clear();
          await checkActiveUser();
          update();
        }
      }
      // log(requests.body);
    } catch (e) {
      // Get.snackbar("Error", "Something went wrong",
      //     backgroundColor: Colors.red);
    }
  }

  RxInt invoiceTotalpage = 1.obs;
  var invoiceCurrentpage = 1.obs;
  ondropDownChangedInvoice(id) async {
    if (invoiceCurrentpage.value > invoiceTotalpage.value) {
      return;
    }
    var invoiceBody = {"shop_id": id, "page": invoiceCurrentpage.value};
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-invoice-filter-by-shop/"),
        headers: headers,
        body: jsonEncode(invoiceBody));
    log(request.statusCode.toString());
    if (request.statusCode == 201) {
      final invoiceData = invoiceDataFromJson(request.body);
      invoiceTotalpage.value = invoiceData.totalPages;

      if (invoiceCurrentpage.value == 1) {
        invoiceLists.value.assignAll(invoiceData.invoiceData);
        invoiceListsFilter.value.assignAll(invoiceData.invoiceData);

        filterListValue.value = "All";
        searchInvoiceLists.clear();
        searchWalletTransactionList.clear();
        await checkActiveUser();
        update();
      } else {
        invoiceLists.value.addAll(invoiceData.invoiceData);
        invoiceListsFilter.value.addAll(invoiceData.invoiceData);

        filterListValue.value = "All";
        searchInvoiceLists.clear();

        await checkActiveUser();
        update();
      }
    }
  }

  var isInvoiceLoading = false.obs;
  Future<void> invoiceScroll() async {
    if (invoiceScrollController.position.pixels ==
        invoiceScrollController.position.maxScrollExtent) {
      isInvoiceLoading.value = true;
      invoiceCurrentpage.value++;
      log("hai");
      await ondropDownChangedInvoice(selectShopId);
      isInvoiceLoading.value = false;
      update();
    }
  }

  var isWalletLoading = false.obs;
  Future<void> walletTransactionScroll() async {
    if (walletTransactionScrollController.position.pixels ==
        walletTransactionScrollController.position.maxScrollExtent) {
      isWalletLoading.value = true;
      walletCurrentpage.value++;
      log("hai");
      await onDropDownChanged(selectShopId);
      isWalletLoading.value = false;
      update();
    }
  }

  onPullRefreshInWallet() async {
    walletCurrentpage.value = 1;
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
        // invoiceLists.value.clear();
        final invoiceData = invoiceDataFromJson(request.body);
        invoiceLists.value.assignAll(invoiceData.invoiceData);
        invoiceListsFilter.value.assignAll(invoiceData.invoiceData);
        filterListValue.value = "All";
        searchInvoiceLists.clear();
        update();
      }
      if (requests.statusCode == 201) {
        final walletScreenModel = walletScreenModelFromJson(requests.body);
        walletTransactionLists.assignAll(walletScreenModel.transactionData);
        walletAmount.value = walletScreenModel.shopWalletAmount.toString();
        searchWalletTransactionList.clear();
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
  var filterPage = 1.obs;
  RxInt totalFilterPage = 1.obs;
  final filterScrolController = ScrollController();
  onFilterListChange() async {
    if (filterPage.value > totalFilterPage.value) {
      return;
    }
    invoiceLists.value.clear();
    dynamic body;
    if (filterListValue.value == "All") {
      log("1");
      body = {"shop_id": 1, "status": "All", "page": filterPage.value};
    } else if (filterListValue.value == "Approved") {
      log("2");
      body = {"shop_id": 1, "status": "Approve", "page": filterPage.value};
    } else if (filterListValue.value == "Pending") {
      log("3");
      body = {"shop_id": 1, "status": "Pending", "page": filterPage.value};
    } else {
      log("4");
      body = {"shop_id": 1, "status": "Reject", "page": filterPage.value};
    }

    final request = await http.post(
        Uri.parse("${baseUrl.value}shop-invoice-filter-by-status/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      final invoiceData = invoiceDataFromJson(request.body);
      totalFilterPage.value = invoiceData.totalPages;
      if (filterPage.value == 1) {
        invoiceLists.value.assignAll(invoiceData.invoiceData);
        update();
      } else {
        invoiceLists.value.addAll(invoiceData.invoiceData);
        update();
      }
    }
  }

  Future<void> filterScrollListener() async {
    if (filterScrolController.position.maxScrollExtent ==
        filterScrolController.offset) {
      isInvoiceLoading.value = true;
      filterPage.value++;
      log("hello");
      await onFilterListChange();
      isInvoiceLoading.value = false;
      update();
    }
  }

  RxList<dynamic> debitList = ['All', 'Debit', 'Credit'].obs;
  var debitListValue = 'All'.obs;
  DateTime? startDate;
  DateTime? endDate;
  DateTimeRange? selecteds;
  var currentDatePage = 1.obs;
  RxInt totalDatePage = 1.obs;
  final dateRangeScrollController = ScrollController();
  dateSelect({context}) async {
    DateTimeRange? newRange;
    final initialDate = DateTimeRange(
        start: DateTime.now().add(const Duration(days: -2)),
        end: DateTime.now());
    selecteds = (await showDateRangePicker(
      context: context,
      initialDateRange: newRange ?? initialDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ));

    if (selecteds == null) {
      return;
    } else {
      startDate = selecteds!.start;
      endDate = selecteds!.end;

      await fetChDateRange();
      update();
      // walletTransactionLists.value = walletTransactionLists2.where((list) {
      //   DateTime date =
      //       DateFormat('yyyy MMM dd, hh:mm a').parse(list.createdAt);
      //   DateTime dates = DateTime.parse(date.toString());
      //   return dates.isAtSameMomentAs(startDate!) ||
      //       dates.isAfter(startDate!) &&
      //           dates.isBefore(endDate!.add(Duration(days: 1)));
      // }).toList();

      // log(startDate.toString());
      // log(endDate.toString());
    }
  }

  fetChDateRange() async {
    if (selecteds == null || currentDatePage.value > totalDatePage.value) {
      return;
    }
    final entryType =
        debitListValue.value == "All" ? null : debitListValue.value;
    startDate = selecteds!.start;
    endDate = selecteds!.end;
    walletTransactionLists.clear();
    DateTime date = DateTime.parse(startDate.toString());
    String formattedStartDate = DateFormat('yyyy-MM-dd').format(date);
    DateTime date2 = DateTime.parse(endDate.toString());
    String formattedEndDate = DateFormat('yyyy-MM-dd').format(date2);
    final body = {
      "shop_id": selectShopId,
      "date_from": formattedStartDate,
      "date_to": formattedEndDate,
      "page": currentDatePage.value,
      "entry_type": entryType
    };
    final request = await http.post(
        Uri.parse("${baseUrl.value}filter-shop-wallet-transactions-date/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      final walletScreenModel = walletScreenModelFromJson(request.body);
      totalDatePage.value = walletScreenModel.totalPages;
      if (currentDatePage.value == 1) {
        walletTransactionLists.assignAll(walletScreenModel.transactionData);
        update();
      } else {
        walletTransactionLists.addAll(walletScreenModel.transactionData);
        update();
      }
    }
  }

  var isDateMoving = false.obs;
  dateRangeScrollListener() async {
    if (dateRangeScrollController.position.maxScrollExtent ==
        dateRangeScrollController.offset) {
      isDateMoving.value = true;
      currentDatePage.value++;
      log("haidfg");
      await fetChDateRange();
      isDateMoving.value = false;
      update();
    }
  }

  RxList<InvoiceDatas> searchInvoiceLists = <InvoiceDatas>[].obs;
  var isFetching = false.obs;

  final TextEditingController searchInvoiceController = TextEditingController();
  RxInt totalpage = 1.obs;
  var page = 1.obs;

  final scrollController = ScrollController();
  fetchData() async {
    if (page.value > totalpage.value) {
      return;
    }
    final body = {
      "shop_id": selectShopId,
      "search_key": searchInvoiceController.text,
      "page": page.value
    };
    final response = await http.post(
        Uri.parse("${baseUrl.value}vendor-invoice-search/"),
        body: jsonEncode(body),
        headers: headers);
    log(response.body);

    if (response.statusCode == 201) {
      final searchInvoiceData = searchInvoiceDataFromJson(response.body);
      totalpage.value = searchInvoiceData.totalPages;

      if (page.value == 1) {
        searchInvoiceLists.assignAll(searchInvoiceData.invoiceData);
        update();
      } else {
        searchInvoiceLists.addAll(searchInvoiceData.invoiceData);
        update();
      }

      update();
    }
  }

  Future<void> scrollListner() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      isFetching.value = true;
      page.value++;
      log("hai");
      await fetchData();
      isFetching.value = false;
      update();
    }
  }

  final TextEditingController searchWalletTextController =
      TextEditingController();
  RxList<WalletTransactionDatum> searchWalletTransactionList =
      <WalletTransactionDatum>[].obs;
  var isMoving = false.obs;
  final currentPage = 1.obs;
  RxInt walletTotalpage = 1.obs;
  final walletScrollController = ScrollController();
  Future<void> searchWalletTransactions() async {
    if (currentPage.value > walletTotalpage.value) {
      return;
    }

    final body = {
      "shop_id": selectShopId,
      "search_key": searchWalletTextController.text,
      "page": currentPage.value
    };
    try {
      final response = await http.post(
          Uri.parse("${baseUrl.value}search-shop-wallet-transactions/"),
          body: jsonEncode(body),
          headers: headers);
      log(response.body);
      if (response.statusCode == 201) {
        final searchWalletTransaction =
            searchWalletTransactionFromJson(response.body);
        walletTotalpage.value = searchWalletTransaction.totalPages;

        if (currentPage.value == 1) {
          searchWalletTransactionList
              .assignAll(searchWalletTransaction.transactionData);
          update();
        } else {
          searchWalletTransactionList
              .addAll(searchWalletTransaction.transactionData);
          update();
        }

        update();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> walletScroll() async {
    if (walletScrollController.position.maxScrollExtent ==
        walletScrollController.offset) {
      isMoving.value = true;
      currentPage.value++;
      log("hai");
      await searchWalletTransactions();
      isMoving.value = false;
      update();
    }
  }

  Future<bool?> checkActiveUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {"user_id": userId};
    try {
      final request = await http.post(
          Uri.parse("${baseUrl.value}check-vendor-active/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body);
      if (request.statusCode == 201) {
        final jsonData = jsonDecode(request.body);
        if (jsonData["is_active"] == true) {
          return true;
        } else {
          await prefs.clear();
          Get.offAll(RequestPendingView());
          return false;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
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

      print("token:$token");
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
