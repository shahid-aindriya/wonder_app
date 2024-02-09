import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:wonder_app/app/modules/bottom_bar/views/bottom_bar_view.dart';

import 'package:wonder_app/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice/widgets/payment/pay_data_model.dart';

import 'package:wonder_app/app/modules/invoice/widgets/verifed_invoice/verified_invoices.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key, this.data, required this.invoiceController});

  final PaymentData? data;
  final InvoiceController invoiceController;

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  bool loading = true;
  late InAppWebViewController _webViewController;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // _loadHTML();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            //title: new Text('Are you sure?'),
            content: Text('Do you want to cancel this transaction ?'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(BottombarView());
                  Get.to(VerifiedInvoices(
                    invoiceController: widget.invoiceController,
                  ));
                },
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Payment'),
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: InAppWebView(
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        mediaPlaybackRequiresUserGesture: false,
                        javaScriptEnabled: true,
                        javaScriptCanOpenWindowsAutomatically: true,
                      ),
                      android: AndroidInAppWebViewOptions(
                        useWideViewPort: false,
                        useHybridComposition: true,
                        loadWithOverviewMode: true,
                        domStorageEnabled: true,
                      ),
                      ios: IOSInAppWebViewOptions(
                          allowsInlineMediaPlayback: true,
                          enableViewportScale: true,
                          ignoresViewportScaleLimits: true)),
                  initialData: InAppWebViewInitialData(data: _loadHTML()),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  onLoadError: (controller, url, code, message) {
                    print(message);
                  },
                  onLoadStop:
                      (InAppWebViewController controller, Uri? pageUri) async {
                    setState(() {
                      loading = false;
                    });
                    log(".................${pageUri.toString()}..........");
                    print(pageUri.toString());
                    final page = pageUri.toString();

                    if (page == widget.data?.redirectUrl) {
                      Future.delayed(const Duration(seconds: 1), () async {
                        await widget.invoiceController.paymentSuccessForAll();
                        Get.offAll(BottombarView());
                        Get.to(VerifiedInvoices(
                          invoiceController: widget.invoiceController,
                        ));

                        return;
                      });
                    } else if (page == widget.data?.cancelUrl) {
                      Get.offAll(BottombarView());
                      Get.to(VerifiedInvoices(
                        invoiceController: widget.invoiceController,
                      ));
                      Get.snackbar("Error", "Can't complete the transaction",
                          backgroundColor: Colors.red);
                      return;
                    }
                  },
                ),
              ),
              (loading)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(),
            ],
          ),
        ),
      ),
    );
  }

  String _loadHTML() {
    final url = widget.data!.paymentUrl;
    final command = "initiateTransaction";
    final encRequest = widget.data!.encryptKey;
    final accessCode = widget.data!.accessCode;

    String html =
        "<html> <head><meta name='viewport' content='width=device-width, initial-scale=1.0'></head> <body onload='document.f.submit();'> <form id='f' name='f' method='post' action='$url'><input type='hidden' name='command' value='$command'/><input type='hidden' name='encRequest' value='$encRequest' /><input  type='hidden' name='access_code' value='$accessCode' />";
    // print(html);
    return "$html</form> </body> </html>";
  }
}
