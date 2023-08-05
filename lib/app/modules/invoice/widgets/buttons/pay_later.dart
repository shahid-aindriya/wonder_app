import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../model/verified_model.dart';
import '../verifed_invoice/verified_invoices.dart';

class PayLater extends StatelessWidget {
  const PayLater({
    super.key,
    required this.widget,
    required this.amount,
  });

  final VerifiedInvoices widget;

  final TotalAmountData amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
                height: 43,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Color.fromARGB(255, 73, 117, 231), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () async {},
                        child: Obx(() {
                          return widget.invoiceController.dueSelectAmount
                                      .value !=
                                  0
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Pay Later",
                                      style: GoogleFonts.roboto(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 73, 117, 231)),
                                    ),
                                    Text(
                                      "₹${widget.invoiceController.dueSelectAmount.value} Payable to wonder points/user",
                                      style: GoogleFonts.roboto(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                              255, 73, 117, 231)),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Pay Later",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 73, 117, 231)),
                                    ),
                                    Text(
                                      "₹${amount.dueAmount} Payable to wonder points/user",
                                      style: GoogleFonts.roboto(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                              255, 73, 117, 231)),
                                    ),
                                  ],
                                );
                        })))),
          ),
        ],
      ),
    );
  }
}
