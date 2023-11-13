import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controllers/invoice_payment_controller.dart';
import '../../views/invoice_view.dart';

class ProgressIndicatorView extends StatelessWidget {
  ProgressIndicatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment(2, 1.0548897981643677),
            end: Alignment(-1.0548897981643677, 1.226324439048767),
            colors: [
              Color.fromRGBO(239, 221, 214, 1),
              Color.fromRGBO(220, 222, 242, 1),
              Color.fromRGBO(250, 227, 243, 1),
              Color.fromRGBO(228, 249, 254, 1)
            ]),
      ),
      child: WillPopScope(
        onWillPop: () async {
          invoiceController.verifiedList.clear();
          await invoiceController.verifiedInvoiceList();
          invoicePaymentController.progress.value = 0.0;
          invoicePaymentController.count.value = 0;
          invoicePaymentController.listCount.value = 0;

          invoicePaymentController.progressLoading.value = false;
          Get.back();
          throw Exception();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(225, 255, 255, 255),
                      borderRadius: BorderRadius.circular(13)),
                  width: 100.w,
                  child: Column(
                    children: [
                      Obx(() {
                        return Container(
                            height: 79,
                            child: (invoicePaymentController.count.value ==
                                        invoicePaymentController
                                            .listCount.value &&
                                    invoicePaymentController.count.value != 0)
                                ? Icon(
                                    Icons.verified,
                                    color: Colors.green,
                                    size: 55,
                                  )
                                : Image.asset("assets/images/image 11.png"));
                      }),
                      Obx(() {
                        return Text(
                          (invoicePaymentController.count.value ==
                                      invoicePaymentController
                                          .listCount.value &&
                                  invoicePaymentController.count.value != 0)
                              ? "Bulk Approval Completed"
                              : "Bulk Approval Progressing...",
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 73, 86, 178)),
                        );
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w, right: 7.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Obx(() {
                            return LinearProgressIndicator(
                              value: invoicePaymentController.progress.value,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 73, 86, 178)),
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            return Text(invoicePaymentController.count.value
                                .toString());
                          }),
                          Obx(() {
                            return Text(
                                " / ${invoicePaymentController.listCount.value.toString()}");
                          })
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return Visibility(
                  visible: invoicePaymentController.progressLoading.value
                      ? true
                      : false,
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border(),
                        gradient: LinearGradient(
                          begin: Alignment(-0.934, -1),
                          end: Alignment(1.125, 1.333),
                          colors: <Color>[Color(0xe53f46bd), Color(0xe5417de8)],
                          stops: <double>[0, 1],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3f000000),
                            offset: Offset(0, 0.7870440483),
                            blurRadius: 2.7546541691,
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: () async {
                                invoiceController.verifiedList.clear();
                                await invoiceController.verifiedInvoiceList();
                                invoicePaymentController.progress.value = 0.0;
                                invoicePaymentController.count.value = 0;
                                invoicePaymentController.listCount.value = 0;

                                invoicePaymentController.progressLoading.value =
                                    false;
                                Get.back();
                              },
                              child: Text(
                                "Go Back",
                                style: GoogleFonts.roboto(color: Colors.white),
                              )))),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
