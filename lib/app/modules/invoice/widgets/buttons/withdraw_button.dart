import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../model/verified_model.dart';
import '../../views/invoice_view.dart';

class WithdrawButton extends StatelessWidget {
  const WithdrawButton({
    super.key,
    required this.amount,
  });

  final TotalAmountData amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10),
      child: Row(
        children: [
          Expanded(
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
                    child: Obx(() {
                      return ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed:
                              (invoiceController.isWithdrawSend.value == true ||
                                      amount.shopBalance == 0)
                                  ? null
                                  : () async {
                                      invoiceController
                                          .sentWithdrawRequest(context);
                                    },
                          child: invoiceController.isWithdrawSend.value == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              : Text(
                                  "Withdraw",
                                  style:
                                      GoogleFonts.roboto(color: Colors.white),
                                ));
                    }))),
          ),
        ],
      ),
    );
  }
}
