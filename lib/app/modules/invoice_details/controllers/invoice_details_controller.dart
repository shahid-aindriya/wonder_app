import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';

import '../../../data/urls.dart';
import '../../invoice/controllers/invoice_controller.dart';
import '../models/invoice_approval_model.dart';

class InvoiceDetailsController extends GetxController {
  final InvoiceController inoviceController = Get.put(InvoiceController());
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
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void onClose() {
    razorpay.clear();
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

  void _showSnackBar(String message, {id}) {
    Get.snackbar("Info ", message, backgroundColor: Colors.amber);
    log(message);
    if (id != null) {
      paymentSuccess(razorId: id);
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
    final requests = await http.post(
        Uri.parse("${baseUrl.value}vendor-invoice-payment-success/"),
        headers: headers,
        body: jsonEncode(body));
    log(requests.statusCode.toString());
    if (requests.statusCode == 201) {
      Get.snackbar("Info ", "Payment completed succesfully",
          backgroundColor: Colors.green);
      await inoviceController.onDropDownChanged(shopId);
      Get.offAll(InvoiceView());
    }
  }

  void openCheckout({razorKey, amount, invoiceId}) async {
    log(amount.toString());
    String amt = "${amount}00";
    var options = {
      "key": razorKey,
      "amount": int.tryParse(amt),
      "name": "Acme Corp",
      "description": "Test Transaction",
      "prefill": {"contact": "9123456789", "email": "test@razorpay.com"},
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

  approveOrDeclineInvoice({choice, invoiceId, context}) async {
    log(invoiceId.toString());
    var body = {"invoice_id": invoiceId, "status": choice};

    var request = await http.post(
        Uri.parse("${baseUrl.value}vendor-invoice-status-change/"),
        headers: headers,
        body: jsonEncode(body));
    log(request.body.toString());
    if (request.statusCode == 201) {
      final invoiceApprovalModel = invoiceApprovalModelFromJson(request.body);
      if (invoiceApprovalModel.success == true) {
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
        await inoviceController.getInvoiceLists();
        Get.back();
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
      }
    }
  }
}
