import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:wonder_app/app/modules/add_invoice/controllers/add_invoice_controller.dart';

class AmountDetails extends StatelessWidget {
  final AddInvoiceController addInvoiceController;
  final shopId;
  final customerId;
  const AmountDetails(
      {super.key,
      required this.addInvoiceController,
      this.customerId,
      this.shopId});

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(117, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                  onPressed: () async {
                    // await invoiceController!.getInvoiceLists();
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xff4956b2),
                  )),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Amount Details',
            style: GoogleFonts.jost(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff4956b2),
            ),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Container(
                height: 20.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                  gradient: LinearGradient(
                      begin:
                          Alignment(1.1437236070632935, -0.005003529135137796),
                      end:
                          Alignment(-0.06076670065522194, 0.042849887162446976),
                      colors: [
                        Color.fromRGBO(255, 255, 255, 0.75),
                        Color.fromRGBO(255, 255, 255, 0.3199999928474426)
                      ]),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 3.h, left: 4.w, right: 4.w, bottom: 3.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              "Invoice Amount",
                              style: GoogleFonts.jost(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 73, 86, 178)),
                            )),
                            Flexible(
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(14.075627326965332),
                                  color: Color.fromRGBO(234, 228, 233, 1),
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Obx(() {
                                    return Text(
                                        addInvoiceController.amountDetailsList
                                            .first["additional_amount"]
                                            .toString(),
                                        style: GoogleFonts.jost(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 73, 86, 178)));
                                  }),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              "Total Payable",
                              style: GoogleFonts.jost(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 73, 86, 178)),
                            )),
                            Flexible(
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(14.075627326965332),
                                  color: Color.fromRGBO(234, 228, 233, 1),
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Obx(() {
                                    return Text(
                                        addInvoiceController.amountDetailsList
                                            .first["total_verified"]
                                            .toString(),
                                        style: GoogleFonts.jost(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 73, 86, 178)));
                                  }),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Figma Flutter Generator Rectangle57Widget - RECTANGLE
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      begin: Alignment(6.123234262925839e-17, 1),
                      end: Alignment(-1, 6.123234262925839e-17),
                      colors: [
                        Color.fromRGBO(57, 55, 166, 1),
                        Color.fromRGBO(65, 114, 222, 1)
                      ]),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 26),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "User Credit Points",
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() {
                            return Text(
                              addInvoiceController
                                  .amountDetailsList.first["user_credit"]
                                  .toString(),
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                          SizedBox(width: 10),
                          Container(
                            height: 24,
                            width: 24,
                            child: Image.asset(
                              "assets/images/gold.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border(),
                          gradient: LinearGradient(
                            begin: Alignment(-0.934, -1),
                            end: Alignment(1.125, 1.333),
                            colors: <Color>[
                              Color(0xe53f46bd),
                              Color(0xe5417de8)
                            ],
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
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: () async {
                                {
                                  addInvoiceController.dialogPopForAddInvoice(
                                      context, customerId, shopId);
                                  // await addInvoiceController.addInvoice(
                                  //     context, customerId, shopId);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              )),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
