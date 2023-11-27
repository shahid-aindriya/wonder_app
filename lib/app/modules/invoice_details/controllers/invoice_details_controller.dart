import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:razorpay_web/razorpay_web.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/colors.dart';
import '../../../data/urls.dart';
import '../../invoice/controllers/invoice_controller.dart';
import '../../invoice/views/invoice_view.dart';
import '../models/invoice_approval_model.dart';
import '../models/invoice_details_response.dart';

class InvoiceDetailsController extends GetxController {
  //TODO: Implement InvoiceDetailsController

  final count = 0.obs;
  @override
  void onInit() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement onInit
    super.onInit();
  }

  dynamic invoiceId;
  dynamic amount;
  dynamic shopId;
  @override
  void dispose() {
    razorpay.clear();
    dateController.clear();
    taxAmountController.clear();
    invoiceNumberController.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void onClose() {
    razorpay.clear();
    dateController.clear();
    taxAmountController.clear();
    invoiceNumberController.clear();
  }

  void increment() => count.value++;
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

  var isLoading = false.obs;
  void _showSnackBar(String message, {id}) async {
    Get.snackbar("Info ", message, backgroundColor: Colors.amber);
    log(message);
    if (id != null) {
      isLoading.value = true;
      await paymentSuccess(razorId: id);
      isLoading.value = false;
    }
  }

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
      final requests = await http.post(
          Uri.parse("${baseUrl.value}vendor-invoice-payment-success/"),
          headers: headers,
          body: jsonEncode(body));
      log(requests.body.toString());
      if (requests.statusCode == 201) {
        Get.snackbar("Info ", "Payment completed succesfully",
            backgroundColor: Colors.green);
        await invoiceController.onPullRefreshInWallet();
        Get.offAll(InvoiceView());
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

  openCheckout(
      {razorKey, amount, invoiceId, name, email, required dynamic data}) async {
    if (data.amountData.haveBank == false) {
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

  // Future<void> createOrder({apiKeys, apiSecrets, invoiceId, amount}) async {
  //   String amt = "${amount}00";
  //   final String apiKey = apiKeys;
  //   final String apiSecret = apiSecrets;
  //   final String basicAuth =
  //       'Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}';

  //   final Map<String, dynamic> body = {
  //     "amount": int.tryParse(amt),
  //     "currency": "INR",
  //     "receipt": invoiceId.toString(),
  //   };

  //   final http.Response response = await http.post(
  //     Uri.parse('https://api.razorpay.com/v1/orders'),
  //     headers: {'authorization': basicAuth, 'content-type': 'application/json'},
  //     body: json.encode(body),
  //   );
  //   // log(response.body);
  //   if (response.statusCode == 201) {
  //     var orders = jsonDecode(response.body);
  //     print(orders);
  //     String orderId = orders['id'];
  //     // Use the orderId to initiate payment
  //     openCheckout(amount: amount, invoiceId: invoiceId, razorKey: apiKeys);
  //   } else {
  //     print('Failed to create order: ${response.body}');
  //   }
  // }
  var isButtonLoad = false.obs;
  approveOrDeclineInvoice(
      {choice,
      invoiceId,
      context,
      remarks,
      InvoiceController? inoviceController}) async {
    isLoading.value = true;
    log(invoiceId.toString());
    var body = {"invoice_id": invoiceId, "status": choice, "remark": remarks};
    try {
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-invoice-status-change/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body.toString());
      if (request.statusCode == 201) {
        final invoiceApprovalModel = invoiceApprovalModelFromJson(request.body);
        if (invoiceApprovalModel.success == true) {
          await getInvoiceDetails(invoiceId: invoiceId);
          await invoiceController.onPullRefreshInWallet();
          await invoiceController
              .ondropDownChangedInvoice(invoiceController.selectShopId);
          invoiceController.currentVerifiedCount.value = 1;
          invoiceController.verifiedList.clear();
          await inoviceController!.verifiedInvoiceList();

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
            description: Text('Invoice $choice successfully'),
            animationCurve: Curves.bounceIn,
            borderRadius: 0,
            animationDuration: const Duration(milliseconds: 1000),
          ).show(context);
          isLoading.value = false;
        } else {
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
          isLoading.value = false;
        }
      } else {
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
          description: Text('Something went wrong or Server error'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
    } catch (e) {
      // Get.snackbar("Error", "Something went wrong",
      //     backgroundColor: Colors.red);
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  RxList<InvoiceDetailsResponse> invoiceDetailsList =
      <InvoiceDetailsResponse>[].obs;

  getInvoiceDetails({invoiceId}) async {
    var body = {"invoice_id": invoiceId};
    final requests = await http.post(
        Uri.parse("${baseUrl.value}vendor-invoice-details/"),
        body: jsonEncode(body));
    log(requests.body);
    if (requests.statusCode == 201) {
      final invoiceDetailsResponse =
          invoiceDetailsResponseFromJson(requests.body);
      invoiceDetailsList.assign(invoiceDetailsResponse);
    }
  }

  final TextEditingController taxAmountController = TextEditingController();
  final TextEditingController invoiceNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final taxFormKey = GlobalKey<FormState>();
  showPopupTax({context, id, amount, invoiceNumber, date}) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    Alert(
      context: context,
      title: "Edit Data",
      style: AlertStyle(
          overlayColor: Color.fromARGB(120, 0, 0, 0),
          titleStyle: GoogleFonts.jost(
              color: textGradientBlue, fontWeight: FontWeight.w500)),
      content: Column(
        children: <Widget>[
          Form(
            key: taxFormKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: taxAmountController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.currency_rupee),
                    labelText: 'Enter Tax amount',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: invoiceNumberController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.textsms_sharp),
                    labelText: 'Enter Invoice Number',
                  ),
                ),
                TextFormField(
                  controller: dateController,
                  keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range_outlined),
                    labelText: 'Enter Invoice Date',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary,
                              ),
                              colorScheme: ColorScheme.light(
                                primary: Color(0xe53f46bd),
                              ).copyWith(secondary: Colors.pink),
                            ),
                            child: child!,
                          );
                        },
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            1900), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      dateController.text = formattedDate;
                    } else {
                      var newFormat = DateFormat('yyyy-MM-dd').format(date);
                      dateController.text = newFormat;
                    }
                    return;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          gradient: LinearGradient(
            begin: Alignment(-0.934, -1),
            end: Alignment(1.125, 1.333),
            colors: <Color>[Color(0xe53f46bd), Color(0xe5417de8)],
            stops: <double>[0, 1],
          ),
          radius: BorderRadius.circular(10),
          onPressed: () {
            var taxAmount = taxAmountController.text.isEmpty
                ? amount.toString()
                : taxAmountController.text;
            var invoiceDate = dateController.text.isEmpty
                ? formattedDate
                : dateController.text;
            var invNumber = invoiceNumberController.text.isEmpty
                ? invoiceNumber
                : invoiceNumberController.text;
            log(invoiceDate.toString());
            if (taxFormKey.currentState!.validate()) {
              editTaxAmount(
                  invoiceId: id,
                  amount: int.tryParse(taxAmount),
                  date: invoiceDate,
                  invoiceNumber: invNumber);
            }
          },
          child: Obx(() {
            return editButton.value == true
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  );
          }),
        )
      ],
    ).show();
  }

  var editButton = false.obs;
  editTaxAmount({invoiceId, amount, date, invoiceNumber}) async {
    var body = {
      "invoice_id": invoiceId,
      "pretax_amount": amount,
      "invoice_date": date,
      "invoice_number": invoiceNumber
    };
    try {
      editButton.value = true;
      final requests = await http.post(
          Uri.parse("${baseUrl.value}vendor-update-pretax_amount/"),
          body: jsonEncode(body),
          headers: headers);
      log(requests.body);
      if (requests.statusCode == 201) {
        invoiceController.invoiceCurrentpage.value = 1;
        await invoiceController
            .ondropDownChangedInvoice(invoiceController.selectShopId);
        await invoiceController.verifiedInvoiceList();
        await getInvoiceDetails(invoiceId: invoiceId);
        await invoiceController.onPullRefreshInWallet();

        dateController.clear();
        taxAmountController.clear();
        invoiceNumberController.clear();
        final response = jsonDecode(requests.body);
        if (response["success"] == true) {
          Get.snackbar("Info ", "Edited Succesfully",
              backgroundColor: Colors.green);
        }
        editButton.value = false;
      } else {
        Get.snackbar("Error", "Something went wrong",
            backgroundColor: Colors.red);
        editButton.value = false;
      }
      editButton.value = false;
    } catch (e) {
      editButton.value = false;
    }
  }

  final TextEditingController remarksController = TextEditingController();
  final remarksKey = GlobalKey<FormState>();
  deletePopup({context, invoiceId}) {
    Alert(
      context: context,
      title: "Enter Remarks",
      style: AlertStyle(
          overlayColor: Color.fromARGB(120, 0, 0, 0),
          titleStyle: GoogleFonts.jost(
              color: textGradientBlue, fontWeight: FontWeight.w500)),
      content: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.text,
            controller: remarksController,
            decoration: InputDecoration(
              icon: Icon(Icons.edit_document),
              labelText: 'Enter remarks',
            ),
            // validator: (value) {
            //   if (value!.isEmpty) {
            //     return "Please Enter Remarks";
            //   }
            //   return null;
            // },
          ),
        ],
      ),
      buttons: [
        DialogButton(
          gradient: LinearGradient(
            begin: Alignment(-0.934, -1),
            end: Alignment(1.125, 1.333),
            colors: <Color>[Color(0xe53f46bd), Color(0xe5417de8)],
            stops: <double>[0, 1],
          ),
          radius: BorderRadius.circular(10),
          onPressed: () async {
            Get.back();
            await approveOrDeclineInvoice(
                inoviceController: invoiceController,
                context: context,
                choice: "Reject",
                remarks: remarksController.text,
                invoiceId: invoiceId);
          },
          child: Obx(() {
            return editButton.value == true
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    "Decline",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  );
          }),
        )
      ],
    ).show();
  }
}
